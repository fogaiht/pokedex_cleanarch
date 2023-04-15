import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/domain/entities/pokemon_entity.dart';
import '../../../shared/shared_files.dart';
import '../../../shared/utils/pokedex_state.dart';
import 'components/tochlight_toggle.dart';
import 'reader_controller.dart';

class ReaderPage extends StatefulWidget {
  final Future<Either<IError, Pokemon>> Function(String) onRead;
  final PokedexState pokedexState;
  final IError? error;

  const ReaderPage({
    Key? key,
    required this.onRead,
    required this.pokedexState,
    this.error,
  }) : super(key: key);

  static const routeName = '/reader';

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  late ReaderController _controller;
  late MobileScannerController _cameraController;
  late NavigatorState _navigator;

  @override
  void initState() {
    _controller = ReaderController();
    _cameraController = MobileScannerController();

    _navigator = Navigator.of(context);
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.stop();
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size1 = context.constSize1;
    return Scaffold(
      body: Observer(builder: (_) {
        return Column(
          children: [
            const Spacer(),
            SizedBox(height: size1 * 60),
            Text(
              'Scaneie o QR-Code do Cartão',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.merge(
                    TextStyle(
                      color: ThemeColors.textColor,
                      fontSize: size1 * 30,
                    ),
                  ),
            ),
            SizedBox(height: size1 * 10),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  context.width * .1,
                  0,
                  context.width * .1,
                  0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ThemeColors.primaryColor,
                      width: size1 * 5,
                    ),
                  ),
                  child: Observer(builder: (_) {
                    return MobileScanner(
                      controller: _cameraController,
                      onDetect: (barcode) async {
                        if (!_controller.isReaded) {
                          final qrData = barcode.barcodes.first.rawValue ?? '';
                          await _controller.readCardQr(
                            qrData,
                            scannerController: _cameraController,
                            onRead: (decodeResponse) {
                              if (_cameraController.torchState.value ==
                                  TorchState.on) {
                                _cameraController.toggleTorch();
                              }
                              return widget.onRead(decodeResponse);
                            },
                          );
                          _navigator.pop();
                        }
                      },
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: size1 * 10),
            TochlightToggle(scannerController: _cameraController),
            const Spacer(),
          ],
        );
      }),
    );
  }
}
