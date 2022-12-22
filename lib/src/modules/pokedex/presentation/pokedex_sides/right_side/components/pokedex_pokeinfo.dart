import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/domain/entities/pokemon_entity.dart';
import '../../../../../../core/external/mappers/pokemon_entity_mapper.dart';
import '../../../../../../shared/data/extensions.dart';
import 'pokedex_base_stats.dart';

class PokeInfo extends StatefulWidget {
  final Pokemon? selectedPokemon;

  const PokeInfo({
    super.key,
    this.selectedPokemon,
  });

  @override
  _PokeInfoState createState() => _PokeInfoState();
}

class _PokeInfoState extends State<PokeInfo> {
  late Pokemon selectedPokemon;
  late Color selectedPokemonColor;

  @override
  void initState() {
    selectedPokemon = widget.selectedPokemon ?? PokemonEntityMapper.empty();
    selectedPokemonColor = HexColor.fromHex(selectedPokemon.types.first.color);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width * 0.91;
    double heightSize = MediaQuery.of(context).size.height * 0.848;

    return ClipPath(
      clipper: _ClipScreen(),
      child: Container(
        width: widthSize,
        height: heightSize,
        decoration: BoxDecoration(color: selectedPokemonColor),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: widthSize * 0.015,
              top: heightSize * 0.015,
              child: Opacity(
                opacity: 0.1,
                child: SizedBox(
                  width: heightSize * 0.23,
                  height: heightSize * 0.23,
                  child: SvgPicture.asset('images/pokeball.svg'),
                ),
              ),
            ),
            Positioned(
              left: widthSize * 0.11,
              top: heightSize * 0.05,
              child: const Text(
                'Quem é',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'Pokemon',
                  color: Colors.yellow,
                ),
              ),
            ),
            Positioned(
              left: widthSize * 0.2,
              top: heightSize * 0.12,
              child: const Text(
                'esse Pokémon?',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'Pokemon',
                  color: Colors.yellow,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: heightSize * 0.474,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(heightSize * 0.035),
                    topRight: Radius.circular(heightSize * 0.035),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: PokedexBaseStats(selectedPokemon: selectedPokemon),
            ),
            Positioned(
              top: heightSize * 0.2,
              child: SizedBox(
                width: widthSize,
                height: heightSize,
                child: Stack(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Positioned(
                      bottom: heightSize * 0.72,
                      left: widthSize * 0.1,
                      right: widthSize * 0.1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: heightSize * 0.245,
                            height: heightSize * 0.245,
                            decoration: const BoxDecoration(
                                // color: Colors.green[800],
                                // border: Border.all(width: 1, color: Colors.black),
                                ),
                            child: Transform.scale(
                              scale: 2.3,
                              child: Image.network(selectedPokemon.spriteUrl),
                            ),
                          ),
                          SizedBox(
                            width: heightSize * 0.245,
                            child: Text(
                              '— ${selectedPokemon.name} —',
                              style: TextStyle(
                                fontSize: heightSize * 0.03,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: heightSize * 0.05,
                      right: 0,
                      child: Container(
                        width: widthSize * 0.256,
                        height: heightSize * 0.1,
                        decoration: const BoxDecoration(
                            // color: Colors.green[800],
                            // border: Border.all(width: 1, color: Colors.red),
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '#${selectedPokemon.id}',
                              style: const TextStyle(
                                fontSize: 30,
                                fontFamily: 'Pokemon',
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: heightSize * 0.185,
                      right: widthSize * 0.05,
                      child: Column(
                        children: [
                          Container(
                            width: widthSize * 0.256,
                            height: heightSize * 0.125,
                            decoration: const BoxDecoration(
                                // color: Colors.green[800],
                                // border: Border.all(width: 1, color: Colors.red),
                                ),
                            child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                // border:
                                //     Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Transform.scale(
                                scale: .9,
                                child: SvgPicture.asset(
                                  'images/captured_pokeball.svg',
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Captured',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: heightSize * 0.03,
                              fontFamily: 'Pokemon',
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: heightSize * 0.2,
                      left: 0,
                      child: Container(
                        width: widthSize * 0.256,
                        height: heightSize * 0.125,
                        decoration: const BoxDecoration(
                            // color: Colors.green[800],
                            // border: Border.all(width: 1, color: Colors.red),
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: widthSize * 0.18,
                              child: Center(
                                child: Text(
                                  'Type',
                                  style: TextStyle(
                                    fontSize: heightSize * 0.025,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                            ),
                            ...selectedPokemon.types.map(
                              (e) => Container(
                                width: widthSize * 0.18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: HexColor.fromHex(e.color),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    e.name,
                                    style: TextStyle(
                                      fontSize: heightSize * 0.02,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClipScreen extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // path.lineTo(0.0, size.height);
    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width, size.height * 0.1);
    // path.lineTo(size.width * 0.62, size.height * 0.1);
    // path.lineTo(size.width * 0.46, 0.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.11);
    path.lineTo(size.width * 0.59, size.height * 0.11);
    path.lineTo(size.width * 0.41, size.height * 0.01);
    path.lineTo(0.0, size.height * 0.01);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
