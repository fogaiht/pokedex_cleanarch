import '../../../shared/errors/datasource_error.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/entities/pokemon_stat_entity.dart';
import '../../domain/entities/pokemon_type_entity.dart';
import '../mapper_errors/pokemon_entity_mapper_error.dart';
import 'pokemon_stat_entity_mapper.dart';
import 'pokemon_type_entity_mapper.dart';

class PokemonEntityMapper extends Pokemon {
  const PokemonEntityMapper({
    required super.name,
    required super.id,
    required super.isShiny,
    required super.spriteUrl,
    required super.stats,
    required super.types,
  });

  static Pokemon fromJson(Map<String, dynamic> json) {
    try {
      return Pokemon(
        name: json['name'],
        id: json['pokemonId'],
        isShiny: json['isShiny'],
        spriteUrl: json['spriteUrl'],
        stats: List<PokemonStat>.from(
          json['stats'].map((e) => PokemonStatEntityMapper.fromJson(e)),
        ),
        types: List<PokemonType>.from(
          json['types'].map((e) => PokemonTypeEntityMapper.fromJson(e)),
        ),
      );
    } on DataSourceError {
      rethrow;
    } catch (e, s) {
      throw PokemonEntityMapperError(
        stackTrace: s,
        errorMessage: 'Error: ${e.toString()}',
      );
    }
  }

  static Map<String, dynamic> toJsonFromEntity(Pokemon entity) => {
        'name': entity.name,
        'pokemonId': entity.id,
        'isShiny': entity.isShiny,
        'spriteUrl': entity.spriteUrl,
        'stats': entity.stats.map(
          (e) => PokemonStatEntityMapper.toJsonFromEntity(e),
        ),
        'types':
            entity.types.map((e) => PokemonTypeEntityMapper.toJsonFromEntity(e))
      };

  static Pokemon empty() => const Pokemon(
        name: '',
        id: 0,
        isShiny: false,
        spriteUrl: '',
        stats: [],
        types: [],
      );
}
