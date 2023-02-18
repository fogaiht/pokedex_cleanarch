import '../../../../shared/object_values/export/object_values.dart';

class ReadPokemonParams {
  final PokemonId pokemonId;
  final bool isShiny;

  ReadPokemonParams({required this.pokemonId, this.isShiny = false});

  Map<String, dynamic> toBodyRequest() => {
        'pokeId': int.tryParse(pokemonId.value) ?? -1,
        'isShiny': isShiny,
      };

  factory ReadPokemonParams.fromJson(Map<String, dynamic> json) =>
      ReadPokemonParams(
        pokemonId: PokemonId(json['pokeId'].toString()),
        isShiny: json['isShiny'],
      );
}
