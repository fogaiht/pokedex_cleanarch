import '../../../../core/external/mappers/pokemon_entity_mapper.dart';
import '../../../../core/external/mappers/user_entity_mapper.dart';
import '../../../../shared/errors/datasource_error.dart';
import '../../domain/entities/read_pokemon_response.dart';
import '../mapper_errors/read_pokemon_response_mapper_error.dart';

class ReadPokemonResponseMapper {
  static ReadPokemonResponse fromJson(Map<String, dynamic> json) {
    try {
      return ReadPokemonResponse(
        readedPokemon: PokemonEntityMapper.fromJson(json['pokemon']),
        user: UserEntityMapper.fromJson(json['user']),
      );
    } on DataSourceError {
      rethrow;
    } catch (e, s) {
      throw ReadPokemonResponseMapperError(
        errorMessage: 'Error: ${e.toString()}',
        stackTrace: s,
      );
    }
  }
}
