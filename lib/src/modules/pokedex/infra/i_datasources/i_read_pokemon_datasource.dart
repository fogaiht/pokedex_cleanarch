import '../../domain/entities/read_pokemon_response.dart';
import '../../domain/params/read_pokemon_params.dart';

abstract class IReadPokemonDatasource {
  Future<ReadPokemonResponse> call(ReadPokemonParams params);
}
