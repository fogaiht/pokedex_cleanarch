import 'package:flutter/material.dart';

import '../../../../../../core/domain/entities/pokemon_entity.dart';
import 'poke_join_right.dart';
import 'pokedex_screen_right.dart';

class PokedexRight extends StatelessWidget {
  final Pokemon selectedPokemon;
  const PokedexRight({super.key, required this.selectedPokemon});

  @override
  Widget build(BuildContext context) {
    // double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Positioned(
          top: heightSize * 0.152,
          bottom: heightSize * 0.025,
          child: PokedexScreenRight(selectedPokemon: selectedPokemon),
        ),
        Positioned(
          bottom: heightSize * 0.025,
          left: 0,
          child: const PokejoinRight(),
        ),
      ],
    );
  }
}
