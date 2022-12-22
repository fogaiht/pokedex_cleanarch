import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_cleanarch/src/modules/pokedex/pokedex_module.dart';
import 'package:pokedex_cleanarch/src/shared/errors/domain_error.dart';
import 'package:pokedex_cleanarch/src/shared/object_values/export/object_values.dart';

class ReadPokemonRepositoryMock extends Mock implements IReadPokemonRepository {
}

class ReadPokemonParamsFake extends Fake implements ReadPokemonParams {}

class ReadPokemonResponseMock extends Mock implements ReadPokemonResponse {}

void main() {
  late ReadPokemonUsecase usecase;
  late IReadPokemonRepository repository;
  late ReadPokemonParams params;
  late ReadPokemonResponse response;

  setUpAll(() {
    registerFallbackValue(ReadPokemonParamsFake());

    repository = ReadPokemonRepositoryMock();
    usecase = ReadPokemonUsecase(repository);
    params = ReadPokemonParams(pokemonId: PokemonId('15'), isShiny: true);
    response = ReadPokemonResponseMock();
  });

  group('ReadPokemonUsecase ->', () {
    test('Return an instance of ReadPokemonResponse', () async {
      when(() => repository(any())).thenAnswer((_) async => Right(response));

      final result = await usecase(params);

      expect(result, isA<Right>());
      expect(result.fold(id, id), isA<ReadPokemonResponse>());
    });

    test('Return an instance of DomainError - Wrong pokemonId', () async {
      params = ReadPokemonParams(pokemonId: PokemonId('teste'), isShiny: true);
      final result = await usecase(params);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DomainError>());
    });
  });
}
