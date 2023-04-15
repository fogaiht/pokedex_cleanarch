import 'package:dartz/dartz.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mobx/mobx.dart';

import '../../../core/domain/entities/pokemon_entity.dart';
import '../../../shared/contracts/i_error.dart';
import '../../../shared/utils/pokedex_state.dart';

part 'reader_controller.g.dart';

class ReaderController = _ReaderControllerBase with _$ReaderController;

abstract class _ReaderControllerBase with Store {
  @observable
  bool isReaded = false;

  @observable
  PokedexState _qrState = PokedexState.start;
  @computed
  PokedexState get qrState => _qrState;
  @action
  void startQrState() => _qrState = PokedexState.start;

  @observable
  IError? decodeError;

  @action
  Future<void> readCardQr(
    String data, {
    required Future<Either<IError, Pokemon>> Function(String) onRead,
    required MobileScannerController scannerController,
  }) async {
    isReaded = true;
    _qrState = PokedexState.loading;
    await onRead(data);
  }
}
