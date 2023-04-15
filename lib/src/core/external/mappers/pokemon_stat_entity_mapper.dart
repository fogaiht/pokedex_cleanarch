import '../../../shared/errors/datasource_error.dart';
import '../../domain/entities/pokemon_stat_entity.dart';
import '../mapper_errors/pokemon_stat_entity_mapper_error.dart';

class PokemonStatEntityMapper extends PokemonStat {
  PokemonStatEntityMapper({
    required super.name,
    required super.value,
  });

  static PokemonStat fromJson(Map<String, dynamic> json) {
    try {
      return PokemonStat(name: json['name'], value: json['statValue']);
    } on DataSourceError {
      rethrow;
    } catch (e, s) {
      throw PokemonStatEntityMapperError(
        stackTrace: s,
        errorMessage: 'Error ${e.toString()}',
      );
    }
  }

  static Map<String, dynamic> toJsonFromEntity(PokemonStat entity) =>
      {'name': entity.name, 'statValue': entity.value};

  static PokemonStat empty() => PokemonStat(name: '', value: 0);
}
