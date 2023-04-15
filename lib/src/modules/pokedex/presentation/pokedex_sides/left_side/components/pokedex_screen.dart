import 'package:flutter/material.dart';

import '../../../../../../core/domain/entities/pokemon_entity.dart';
import '../../../../../../shared/shared_files.dart';
import '../../../../../../shared/utils/pokedex_state.dart';

class PokedexScreen extends StatelessWidget {
  final List<Pokemon> pokemonList;
  final Pokemon? selectedPokemon;
  final PokedexState state;

  const PokedexScreen({
    super.key,
    required this.pokemonList,
    this.selectedPokemon,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height * 0.46;
    return Container(
      height: heightSize,
      width: widthSize,
      color: const Color(0xffE51D20),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: heightSize * 0.105,
            left: widthSize * 0.106,
            child: SizedBox(
              width: widthSize * 0.789,
              height: heightSize * 0.787,
              child: ClipPath(
                clipper: ClipScreen(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(heightSize * 0.05),
                    ),
                    color: const Color(0xffaaaaaa),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: heightSize * 0.234,
            left: widthSize * 0.214,
            child: Container(
              width: widthSize * 0.573,
              height: heightSize * 0.526,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(heightSize * 0.05)),
                color: const Color(0xff222222),
              ),
              child: Center(
                child: state == PokedexState.loading
                    ? const PokedexSpinRing(
                        lineWidth: 5,
                        color: Color(0xff00ff00),
                      )
                    : selectedPokemon == null
                        ? Text(
                            '${pokemonList.length}\nPokemons',
                            style: const TextStyle(
                              color: Color(0xff00ff00),
                              fontSize: 45,
                              fontFamily: 'SevenSegment',
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Transform.scale(
                            scale: 2.3,
                            child: Image.network(
                              selectedPokemon!.spriteUrl,
                            ),
                          ),
              ),
            ),
          ),
          Positioned(
            top: heightSize * 0.156,
            left: widthSize * 0.412,
            child: Container(
              width: widthSize * 0.025,
              height: widthSize * 0.025,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(heightSize * 0.1),
                ),
                color: const Color(0xffff0000),
              ),
            ),
          ),
          Positioned(
            top: heightSize * 0.156,
            right: widthSize * 0.412,
            child: Container(
              width: widthSize * 0.025,
              height: widthSize * 0.025,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(heightSize * 0.1)),
                color: const Color(0xffff0000),
              ),
            ),
          ),
          Positioned(
            bottom: heightSize * 0.156,
            left: widthSize * 0.214,
            child: Container(
              width: widthSize * 0.04,
              height: widthSize * 0.04,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(heightSize * 0.1),
                ),
                color: const Color(0xffff0000),
              ),
            ),
          ),
          Positioned(
            bottom: heightSize * 0.130,
            right: widthSize * 0.214,
            child: SizedBox(
              height: heightSize * 0.08,
              width: widthSize * 0.0756,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: widthSize * 0.0756,
                    height: heightSize * 0.0082,
                    color: const Color(0xff000000),
                  ),
                  Container(
                    width: widthSize * 0.0756,
                    height: heightSize * 0.0082,
                    color: const Color(0xff000000),
                  ),
                  Container(
                    width: widthSize * 0.0756,
                    height: heightSize * 0.0082,
                    color: const Color(0xff000000),
                  ),
                  Container(
                    width: widthSize * 0.0756,
                    height: heightSize * 0.0082,
                    color: const Color(0xff000000),
                  ),
                  Container(
                    width: widthSize * 0.0756,
                    height: heightSize * 0.0082,
                    color: const Color(0xff000000),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClipScreen extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height * 0.837);
    path.lineTo(size.width * 0.137, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
