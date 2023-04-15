import 'pokemon_stat_entity.dart';
import 'pokemon_type_entity.dart';

class Pokemon {
  final String name;
  final int id;
  final bool isShiny;
  final String spriteUrl;
  final List<PokemonStat> stats;
  final List<PokemonType> types;

  const Pokemon({
    required this.name,
    required this.id,
    required this.isShiny,
    required this.spriteUrl,
    required this.stats,
    required this.types,
  });
}
