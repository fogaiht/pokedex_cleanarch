import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../../core/domain/entities/pokemon_entity.dart';
import '../../../../../shared/contracts/i_error.dart';
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
  final Future<Either<IError, Pokemon>> Function(String) readPokemon;
  final void Function() onLogout;

  const LeftSide({
    super.key,
    required this.pokemonList,
    this.selectedPokemon,
    required this.state,
    required this.onSelectPokemon,
    required this.nextPokemon,
    required this.previousPokemon,
    required this.readPokemon,
    required this.onLogout,
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
                PokedexHeader(onLogout: onLogout),
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
