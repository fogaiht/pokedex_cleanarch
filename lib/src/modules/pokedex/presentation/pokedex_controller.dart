import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/domain/entities/pokemon_entity.dart';
import '../../../core/domain/entities/user_entity.dart';
import '../../../core/external/mappers/user_entity_mapper.dart';
import '../../../shared/errors/export/errors.dart';
import '../../../shared/storage/export/storage.dart';
import '../../../shared/utils/pokedex_state.dart';
import '../pokedex_module.dart';

part 'pokedex_controller.g.dart';

class PokedexController = _PokedexControllerBase with _$PokedexController;

abstract class _PokedexControllerBase with Store {
  final IReadPokemonUsecase _readPokemonUsecase;
  final ICustomAppStorage _storage;
  _PokedexControllerBase(this._readPokemonUsecase, this._storage);

  @observable
  PokedexState _pokedexState = PokedexState.start;
  @computed
  PokedexState get pokedexState => _pokedexState;

  @observable
  PokedexState _logoutState = PokedexState.start;
  @computed
  PokedexState get logoutState => _logoutState;

  @observable
  ObservableList<Pokemon> pokemonList = <Pokemon>[].asObservable();

  @action
  Future<void> initData(User? user) async {
    if (user != null) {
      pokemonList.addAll(user.pokemonList);
    } else {
      final userFromStorage = UserEntityMapper.fromJson(
        await _storage.readKey('user'),
      );
      pokemonList.addAll(userFromStorage.pokemonList);
    }
  }

  @action
  Future<void> onLogout() async {
    _logoutState = PokedexState.loading;
    await _storage.deleteAllKeys();
    _logoutState = PokedexState.success;
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
  Future<Either<IError, Pokemon>> doReadPokemon(
    BuildContext context,
    String qrData,
  ) async {
    _pokedexState = PokedexState.loading;
    try {
      final jsonQr = jsonDecode(qrData);
      final params = ReadPokemonParams.fromJson(jsonQr);

      final response = await _readPokemonUsecase(params);
      return response.fold(
        (l) => _doReadPokemonError(l),
        (r) async => await _doReadPokemonSuccess(r, context),
      );
    } catch (e) {
      _pokedexState = PokedexState.error;
      return Left(
        DomainError(message: e.toString(), stackTrace: StackTrace.current),
      );
    }
  }

  int _getReadedPokemonIndex(Pokemon pokemon) {
    return pokemonList.indexWhere((e) => e.id == pokemon.id);
  }

  @action
  Future<Either<IError, Pokemon>> _doReadPokemonSuccess(
    ReadPokemonResponse response,
    BuildContext context,
  ) async {
    pokemonList.clear();
    pokemonList.addAll(response.user.pokemonList);
    _pokemonIndex = _getReadedPokemonIndex(response.readedPokemon);
    selectedPokemon = pokemonList[_pokemonIndex];
    await precacheImage(
      Image.network(selectedPokemon!.spriteUrl).image,
      context,
    );
    _pokedexState = PokedexState.success;
    return Right(selectedPokemon!);
  }

  @action
  Future<Either<IError, Pokemon>> _doReadPokemonError(IError error) async {
    _pokedexState = PokedexState.error;
    return Left(error);
  }
}
