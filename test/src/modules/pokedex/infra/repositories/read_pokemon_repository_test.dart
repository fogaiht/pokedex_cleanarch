import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_cleanarch/src/modules/pokedex/pokedex_module.dart';
import 'package:pokedex_cleanarch/src/shared/errors/datasource_error.dart';

class ReadPokemonDatasourceMock extends Mock implements IReadPokemonDatasource {
}

class ReadPokemonParamsFake extends Fake implements ReadPokemonParams {}

class ReadPokemonResponseMock extends Mock implements ReadPokemonResponse {}

void main() {
  late ReadPokemonRepository repository;
  late IReadPokemonDatasource datasource;
  late ReadPokemonParams params;
  late ReadPokemonResponse response;

  setUpAll(() {
    datasource = ReadPokemonDatasourceMock();
    repository = ReadPokemonRepository(datasource);
    params = ReadPokemonParamsFake();
    response = ReadPokemonResponseMock();
    registerFallbackValue(ReadPokemonParamsFake());
  });

  group('ReadPokemonRepository ->', () {
    test('Return an instance of ReadPokemonResponse', () async {
      when(() => datasource(any())).thenAnswer((_) async => response);

      final result = await repository(params);
      expect(result, isA<Right>());
      expect(result.fold(id, id), isA<ReadPokemonResponse>());
      verify(() => datasource(any())).called(1);
    });
    test('Return an error of DataSourceError', () async {
      when(() => datasource(any())).thenThrow(DataSourceError(
        message: 'Error',
        stackTrace: StackTrace.current,
      ));

      final result = await repository(params);
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DataSourceError>());
      verify(() => datasource(any())).called(1);
    });
    test('Return an instance of DataSourceError when Exception', () async {
      when(() => datasource(any())).thenThrow(Exception('DataSourceError'));

      final result = await repository(params);
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DataSourceError>());
      verify(() => datasource(any())).called(1);
    });
  });
}
