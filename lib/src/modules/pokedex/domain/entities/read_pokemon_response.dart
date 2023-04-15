import '../../../../core/domain/entities/pokemon_entity.dart';
import '../../../../core/domain/entities/user_entity.dart';

class ReadPokemonResponse {
  final Pokemon readedPokemon;
  final User user;

  ReadPokemonResponse({required this.readedPokemon, required this.user});
}
