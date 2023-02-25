import '../../../shared/errors/datasource_error.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../mapper_errors/user_entity_mapper_error.dart';
import 'pokemon_entity_mapper.dart';

class UserEntityMapper extends User {
  UserEntityMapper({
    required super.name,
    required super.email,
    required super.pokemonList,
  });

  static User fromJson(Map<String, dynamic> json) {
    try {
      final pokemonList = List<Pokemon>.from(
        json['pokemonList'].map((e) => PokemonEntityMapper.fromJson(e)),
      );

      pokemonList.sort(((a, b) => a.id.compareTo(b.id)));

      return User(
        name: json['name'],
        email: json['email'],
        pokemonList: pokemonList,
      );
    } on DataSourceError {
      rethrow;
    } catch (e, s) {
      throw UserEntityMapperError(
        stackTrace: s,
        errorMessage: 'Error: ${e.toString()}',
      );
    }
  }

  static Map<String, dynamic> toJsonFromEntity(User entity) => {
        'name': entity.name,
        'email': entity.email,
        'pokemonList': entity.pokemonList
            .map((e) => PokemonEntityMapper.toJsonFromEntity(e))
            .toList(),
      };

  static User empty() => User(name: '', email: '', pokemonList: []);
}
