import 'package:flutter/material.dart';

import '../../../../../core/domain/entities/pokemon_entity.dart';
import '../../../../../shared/theme/colors.dart';
import '../../../../../shared/utils/pokedex_state.dart';
import 'components/export/left_components.dart';

class LeftSide extends StatelessWidget {
  final List<Pokemon> pokemonList;
  final Pokemon? selectedPokemon;
  final PokedexState state;
  final void Function(Pokemon?) onSelectPokemon;
  final void Function(Pokemon?) nextPokemon;
  final void Function(Pokemon?) previousPokemon;
  final void Function() readPokemon;

  const LeftSide({
    super.key,
    required this.pokemonList,
    this.selectedPokemon,
    required this.state,
    required this.onSelectPokemon,
    required this.nextPokemon,
    required this.previousPokemon,
    required this.readPokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                const Spacer(),
                const PokedexHeader(),
                Center(
                  child: PokedexScreen(
                    pokemonList: pokemonList,
                    selectedPokemon: selectedPokemon,
                    state: state,
                  ),
                ),
                PokedexBottom(
                  selectedPokemon: selectedPokemon,
                  onSelectPokemon: onSelectPokemon,
                  nextPokemon: nextPokemon,
                  previousPokemon: previousPokemon,
                  readPokemon: readPokemon,
                ),
                const Spacer(),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: const [
                  Spacer(),
                  PokejoinLeft(),
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
