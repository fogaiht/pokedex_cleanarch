import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../../core/domain/entities/pokemon_entity.dart';

class PokedexBottom extends StatelessWidget {
  final Pokemon? selectedPokemon;
  final void Function(Pokemon?) onSelectPokemon;
  final void Function(Pokemon?) nextPokemon;
  final void Function(Pokemon?) previousPokemon;
  final void Function() readPokemon;

  const PokedexBottom({
    super.key,
    required this.selectedPokemon,
    required this.onSelectPokemon,
    required this.nextPokemon,
    required this.previousPokemon,
    required this.readPokemon,
  });

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height * 0.23;

    return Container(
      height: heightSize,
      width: widthSize,
      decoration: BoxDecoration(
        color: const Color(0xffE51D20),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(heightSize * 0.125),
          bottomLeft: Radius.circular(heightSize * 0.125),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            // bottom: heightSize * 0.3,
            top: heightSize * 0.01,
            right: widthSize * 0.1,
            child: ClipPath(
              clipper: ClipPlus(),
              child: Container(
                width: widthSize * 0.317,
                height: widthSize * 0.317,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  // boxShadow: [
                  //   BoxShadow(
                  //     blurRadius: 5.0,
                  //     offset: Offset(1.0, 3.0),
                  //   ),
                  // ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: heightSize * 0.3,
            // top: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: heightSize,
                  width: widthSize,
                  color: Colors.black.withOpacity(0),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            // bottom: heightSize * 0.314,
            right: widthSize * 0.106,
            child: ClipPath(
              clipper: ClipPlus(),
              child: Container(
                width: widthSize * 0.317,
                height: widthSize * 0.317,
                decoration: const BoxDecoration(
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
          Positioned(
            top: widthSize * 0.106,
            right: widthSize * 0.106,
            child: GestureDetector(
              onTap: () {
                nextPokemon(selectedPokemon);
              },
              child: Container(
                width: widthSize * 0.106,
                height: widthSize * 0.106,
                decoration: const BoxDecoration(
                  color: Color(0xff000000),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                    size: widthSize * 0.106,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: widthSize * 0.106,
            right: widthSize * 0.106 * 3,
            child: GestureDetector(
              onTap: () {
                previousPokemon(selectedPokemon);
              },
              child: Container(
                width: widthSize * 0.106,
                height: widthSize * 0.106,
                decoration: const BoxDecoration(
                  color: Color(0xff000000),
                ),
                child: Center(
                    child: Icon(
                  Icons.arrow_left,
                  color: Colors.white,
                  size: widthSize * 0.106,
                )),
              ),
            ),
          ),
          Positioned(
            bottom: heightSize * 0.4,
            left: widthSize * 0.253,
            child: GestureDetector(
              onTap: () async {
                // String results = await Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ScanView(
                //       cornerColor: Colors.red,
                //     ),
                //   ),
                // );

                // if (results != null) {
                //   widget.pokedexController.addPokemon(results);
                // }

                readPokemon();

                print('LER QR CODE');
              },
              child: Container(
                width: widthSize * 0.286,
                height: heightSize * 0.37,
                decoration: BoxDecoration(
                  color: Colors.green[500],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 3, color: Colors.green.shade300),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5.0,
                      offset: Offset(1.0, 3.0),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.qr_code,
                  size: heightSize * 0.236,
                ),
              ),
            ),
          ),
          Positioned(
            left: widthSize * 0.106,
            top: 0,
            child: GestureDetector(
              onTap: () {
                if (selectedPokemon != null) {
                  onSelectPokemon(selectedPokemon);
                }
              },
              child: Container(
                height: heightSize * 0.236,
                width: heightSize * 0.236,
                decoration: BoxDecoration(
                  color: selectedPokemon == null ? Colors.grey : Colors.black,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0,
                      offset: const Offset(1.0, 3.0),
                      color:
                          selectedPokemon == null ? Colors.white : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//   Future scan() async {
//     try {
//       String barcode = await BarcodeScanner.scan();
//       // setState(() => this.qrScan = barcode);
//       widget.pokedexController.addPokemon(barcode);
//     } on PlatformException catch (e) {
//       if (e.code == BarcodeScanner.CameraAccessDenied) {
//         // setState(() {
//         //   this.qrScan = 'The user did not grant the camera permission!';
//         // });
//       } else {
//         // setState(() => this.qrScan = 'Unknown error: $e');
//       }
//     } on FormatException {
//       // setState(() => this.qrScan = '');
//     } catch (e) {
//       // setState(() => this.qrScan = 'Unknown error: $e');
//     }
//   }
}

class ClipPlus extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width / 3, 0.0);
    path.lineTo(size.width / 3, size.height / 3);
    path.lineTo(0.0, size.height / 3);
    path.lineTo(0.0, 2 * (size.height / 3));
    path.lineTo(size.width / 3, 2 * (size.height / 3));
    path.lineTo(size.width / 3, size.height);
    path.lineTo(2 * (size.width / 3), size.height);
    path.lineTo(2 * (size.width / 3), 2 * (size.height));
    path.lineTo(2 * (size.width / 3), size.height);
    path.lineTo(2 * (size.width / 3), 2 * (size.height / 3));
    path.lineTo((size.width), 2 * (size.height / 3));
    path.lineTo((size.width), (size.height / 3));
    path.lineTo(2 * (size.width / 3), (size.height / 3));
    path.lineTo(2 * (size.width / 3), 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
