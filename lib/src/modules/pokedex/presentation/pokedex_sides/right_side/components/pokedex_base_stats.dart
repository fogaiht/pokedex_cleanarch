import 'package:flutter/material.dart';

import '../../../../../../core/domain/entities/pokemon_entity.dart';
import '../../../../../../shared/data/extensions.dart';

class PokedexBaseStats extends StatelessWidget {
  final Pokemon selectedPokemon;
  const PokedexBaseStats({super.key, required this.selectedPokemon});

  @override
  Widget build(BuildContext context) {
    final selectedPokemonColor = HexColor.fromHex(
      selectedPokemon.types.first.color,
    );

    // double widthSize = widthSize;
    // double heightSize = heightSize;
    double widthSize = MediaQuery.of(context).size.width * 0.9;
    double heightSize = MediaQuery.of(context).size.height * 0.9;
    return SizedBox(
      height: heightSize * 0.3,
      width: widthSize,
      // color: Colors.tealAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: widthSize * 0.9,
                child: Text(
                  'Base Stats',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: heightSize * 0.03,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                // color: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ...selectedPokemon.stats
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Text(
                            e.name.capitalizeFirst,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: heightSize * 0.023,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList()
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ...selectedPokemon.stats
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Text(
                            e.value.toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: heightSize * 0.023,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList()
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ...selectedPokemon.stats
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Stack(
                            children: [
                              Container(
                                width: widthSize * 0.4,
                                height: heightSize * 0.025,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                ),
                              ),
                              Container(
                                width: widthSize * 0.4 * (e.value / 255),
                                height: heightSize * 0.025,
                                decoration: BoxDecoration(
                                    color: selectedPokemonColor,
                                    border: const Border(
                                      top: BorderSide(width: 0.5),
                                      bottom: BorderSide(width: 0.5),
                                      left: BorderSide(width: 0.5),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList()
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
