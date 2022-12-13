import 'pokemon_entity.dart';

class User {
  final String name;
  final String email;
  final List<Pokemon> pokemonList;

  User({
    required this.name,
    required this.email,
    required this.pokemonList,
  });
}
