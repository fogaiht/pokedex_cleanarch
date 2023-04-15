import 'package:flutter/material.dart';

import '../../../../../core/domain/entities/pokemon_entity.dart';
import '../../../../../shared/theme/colors.dart';
import 'components/export/right_components.dart';

class RightPage extends StatelessWidget {
  final Pokemon? selectedPokemon;

  const RightPage({super.key, required this.selectedPokemon});

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ThemeColors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: widthSize * 0.315,
              bottom: widthSize * 0.0518,
              child: PokedexScreenRight(selectedPokemon: selectedPokemon),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: const [
                  Spacer(),
                  PokejoinRight(),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
