import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/domain/entities/pokemon_entity.dart';
import '../../../core/domain/entities/user_entity.dart';
import '../../../shared/contracts/export/contracts.dart';
import '../../../shared/utils/pokedex_state.dart';
import '../pokedex_module.dart';

part 'pokedex_controller.g.dart';

class PokedexController = _PokedexControllerBase with _$PokedexController;

abstract class _PokedexControllerBase with Store {
  final IReadPokemonUsecase _readPokemonUsecase;
  _PokedexControllerBase(this._readPokemonUsecase);

  @observable
  PokedexState _pokedexState = PokedexState.start;
  @computed
  PokedexState get pokedexState => _pokedexState;

  @observable
  ObservableList<Pokemon> pokemonList = <Pokemon>[].asObservable();

  @action
  void initData(User user) {
    pokemonList.addAll(user.pokemonList);
  }

  @observable
  Pokemon? selectedPokemon;
  @action
  void onSelectPokemon(Pokemon? pokemon) {
    selectedPokemon = pokemon;
  }

  @observable
  int _pokemonIndex = -1;

  @action
  void nextPokemon() {
    if (_pokemonIndex < pokemonList.length - 1) {
      _pokemonIndex++;
      selectedPokemon = pokemonList[_pokemonIndex];
    } else {
      selectedPokemon = null;
      _pokemonIndex = -1;
    }
  }

  @action
  void previousPokemon() {
    if (_pokemonIndex == -1) {
      _pokemonIndex = pokemonList.length - 1;
      selectedPokemon = pokemonList[_pokemonIndex];
    } else if (_pokemonIndex == 0) {
      _pokemonIndex = -1;
      selectedPokemon = null;
    } else {
      _pokemonIndex--;
      selectedPokemon = pokemonList[_pokemonIndex];
    }
  }

  @action
  Future<void> doReadPokemon(BuildContext context) async {
    _pokedexState = PokedexState.loading;
    final qrData = {'pokeId': 26, 'isShiny': false};
    final params = ReadPokemonParams.fromJson(qrData);

    final response = await _readPokemonUsecase(params);
    response.fold(
      _doReadPokemonError,
      (r) async => await _doReadPokemonSuccess(r, context),
    );
  }

  int _getReadedPokemonIndex(Pokemon pokemon) {
    return pokemonList.indexWhere((e) => e.id == pokemon.id);
  }

  @action
  Future<void> _doReadPokemonSuccess(
    ReadPokemonResponse response,
    BuildContext context,
  ) async {
    await precacheImage(
      Image.network(selectedPokemon!.spriteUrl).image,
      context,
    );
    _pokedexState = PokedexState.success;
    pokemonList.clear();
    pokemonList.addAll(response.user.pokemonList);
    _pokemonIndex = _getReadedPokemonIndex(response.readedPokemon);
    selectedPokemon = pokemonList[_pokemonIndex];
  }

  @action
  Future<void> _doReadPokemonError(IError error) async {
    _pokedexState = PokedexState.error;
  }
}
