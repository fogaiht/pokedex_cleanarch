import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late PokemonId pokemonId;
  setUp(() {
    pokemonId = PokemonId('123');
  });
  group('PokemonId ObjectValue ->', () {
    test("don't return errorMessage", () {
      expect(pokemonId.hasError(), null);
    });

    test('return empty field message', () {
      pokemonId = PokemonId('');
      expect(pokemonId.hasError(), PokedexTexts.requiredField);
    });
    test('return errorMessage', () {
      pokemonId = PokemonId('a');
      expect(pokemonId.hasError(), pokemonId.errorMessage);
    });
  });
}
