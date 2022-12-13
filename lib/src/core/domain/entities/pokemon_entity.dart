import 'pokemon_stat_entity.dart';

class Pokemon {
  final String name;
  final int pokemonId;
  final bool isShiny;
  final String spriteUrl;
  final List<PokemonStat> stats;

  Pokemon({
    required this.name,
    required this.pokemonId,
    required this.isShiny,
    required this.spriteUrl,
    required this.stats,
  });
}
