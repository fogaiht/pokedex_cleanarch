import '../../../../shared/object_values/export/object_values.dart';

class ReadPokemonParams {
  final PokemonId pokemonId;
  final bool isShiny;

  ReadPokemonParams({required this.pokemonId, this.isShiny = false});

  Map<String, dynamic> toBodyRequest() => {
        'pokeId': pokemonId.value,
        'isShiny': isShiny,
      };

  factory ReadPokemonParams.fromJson(Map<String, dynamic> json) =>
      ReadPokemonParams(
        pokemonId: PokemonId(json['pokemonId']),
        isShiny: json['isShiny'],
      );
}
