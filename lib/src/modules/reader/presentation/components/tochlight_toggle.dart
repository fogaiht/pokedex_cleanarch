import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../shared/shared_files.dart';

class TochlightToggle extends StatelessWidget {
  final MobileScannerController scannerController;
  const TochlightToggle({
    Key? key,
    required this.scannerController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size1 = context.constSize1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          color: Colors.white,
          icon: ValueListenableBuilder(
            valueListenable: scannerController.torchState,
            builder: (context, state, child) {
              switch (state) {
                case TorchState.off:
                  return Icon(
                    Icons.flash_off,
                    color: ThemeColors.disableTextColor,
                  );
                case TorchState.on:
                  return const Icon(
                    Icons.flash_on,
                    color: ThemeColors.primaryColor,
                  );
              }
            },
          ),
          iconSize: size1 * 32.0,
          onPressed: () => scannerController.toggleTorch(),
        ),
        IconButton(
          color: Colors.white,
          icon: ValueListenableBuilder(
            valueListenable: scannerController.cameraFacingState,
            builder: (context, state, child) {
              switch (state) {
                case CameraFacing.front:
                  return const Icon(
                    Icons.camera_front,
                    color: ThemeColors.primaryColor,
                  );
                case CameraFacing.back:
                  return Icon(
                    Icons.camera_rear,
                    color: ThemeColors.disableTextColor,
                  );
              }
            },
          ),
          iconSize: size1 * 32.0,
          onPressed: () => scannerController.switchCamera(),
        ),
      ],
    );
  }
}
