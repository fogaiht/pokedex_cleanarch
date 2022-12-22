import '../../../../core/external/mappers/user_entity_mapper.dart';
import '../../../../shared/errors/datasource_error.dart';
import '../../domain/entities/read_pokemon_response.dart';
import '../mapper_errors/read_pokemon_response_mapper_error.dart';

class ReadPokemonResponseMapper {
  static ReadPokemonResponse fromJson(Map<String, dynamic> json) {
    try {
      return ReadPokemonResponse(
        user: UserEntityMapper.fromJson(json),
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
