import '../../../shared/errors/datasource_error.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/entities/pokemon_stat_entity.dart';
import '../mapper_errors/pokemon_entity_mapper_error.dart';
import 'pokemon_stat_entity_mapper.dart';

class PokemonEntityMapper extends Pokemon {
  PokemonEntityMapper({
    required super.name,
    required super.pokemonId,
    required super.isShiny,
    required super.spriteUrl,
    required super.stats,
  });

  static Pokemon fromJson(Map<String, dynamic> json) {
    try {
      return Pokemon(
        name: json['name'],
        pokemonId: json['pokemonId'],
        isShiny: json['isShiny'],
        spriteUrl: json['spriteUrl'],
        stats: List<PokemonStat>.from(
          json['stats'].map((e) => PokemonStatEntityMapper.fromJson(e)),
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
        'pokemonId': entity.pokemonId,
        'isShiny': entity.isShiny,
        'spriteUrl': entity.spriteUrl,
        'stats': entity.stats.map(
          (e) => PokemonStatEntityMapper.toJsonFromEntity(e),
        ),
      };

  static Pokemon empty() => Pokemon(
        name: '',
        pokemonId: 0,
        isShiny: false,
        spriteUrl: '',
        stats: [],
      );
}
