import 'package:flutter/material.dart';

import '../../../../../core/domain/entities/pokemon_entity.dart';
import 'components/export/left_components.dart';

class LeftSide extends StatelessWidget {
  final List<Pokemon> pokemonList;
  final Pokemon? selectedPokemon;
  final void Function(Pokemon?) onSelectPokemon;
  final void Function(Pokemon?) nextPokemon;
  final void Function(Pokemon?) previousPokemon;

  const LeftSide({
    super.key,
    required this.pokemonList,
    this.selectedPokemon,
    required this.onSelectPokemon,
    required this.nextPokemon,
    required this.previousPokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ),
                ),
                PokedexBottom(
                  selectedPokemon: selectedPokemon,
                  onSelectPokemon: onSelectPokemon,
                  nextPokemon: nextPokemon,
                  previousPokemon: previousPokemon,
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
