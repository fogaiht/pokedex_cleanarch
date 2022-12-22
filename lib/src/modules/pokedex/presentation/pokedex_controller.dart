import 'package:mobx/mobx.dart';

import '../../../core/domain/entities/pokemon_entity.dart';
import '../../../core/domain/entities/user_entity.dart';

part 'pokedex_controller.g.dart';

class PokedexController = _PokedexControllerBase with _$PokedexController;

abstract class _PokedexControllerBase with Store {
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
}
