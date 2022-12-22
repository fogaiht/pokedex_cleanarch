import '../../../shared/errors/datasource_error.dart';
import '../../domain/entities/pokemon_type_entity.dart';
import '../mapper_errors/pokemon_type_entity_mapper_error.dart';

class PokemonTypeEntityMapper extends PokemonType {
  PokemonTypeEntityMapper({required super.name, required super.color});

  static PokemonType fromJson(Map<String, dynamic> json) {
    try {
      return PokemonType(name: json['name'], color: json['color']);
    } on DataSourceError {
      rethrow;
    } catch (e, s) {
      throw PokemonTypeEntityMapperError(
        stackTrace: s,
        errorMessage: 'Error: ${e.toString()}',
      );
    }
  }

  static Map<String, dynamic> toJsonFromEntity(PokemonType entity) => {
        'name': entity.name,
        'color': entity.color,
      };

  static PokemonType empty() => const PokemonType(name: '', color: '');
}
