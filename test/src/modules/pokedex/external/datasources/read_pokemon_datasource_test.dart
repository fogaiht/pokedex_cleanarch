import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_cleanarch/src/modules/pokedex/pokedex_module.dart';
import 'package:pokedex_cleanarch/src/services/http_service/http_service.dart';
import 'package:pokedex_cleanarch/src/shared/errors/export/errors.dart';
import 'package:pokedex_cleanarch/src/shared/object_values/export/object_values.dart';

class HttpServiceMock extends Mock implements IHttpService {}

class RequestOptionsMock extends Mock implements RequestOptions {}

void main() {
  late ReadPokemonDatasource datasource;
  late IHttpService httpServiceMock;
  late ReadPokemonParams params;
  late RequestOptions requestOptions;

  setUp(() {
    httpServiceMock = HttpServiceMock();
    datasource = ReadPokemonDatasource(httpServiceMock);
    params = ReadPokemonParams(pokemonId: PokemonId('15'), isShiny: true);

    requestOptions = RequestOptions(path: '');
  });

  group('ReadPokemonDatasource ->', () {
    test('Return an instance of ReadPokemonResponse', () async {
      when(() => httpServiceMock.post(any(), data: any(named: 'data')))
          .thenAnswer(
        (_) async => Response(
          statusCode: HttpStatus.ok,
          data: payload,
          requestOptions: requestOptions,
        ),
      );

      final response = await datasource(params);
      expect(response, isA<ReadPokemonResponse>());
      verify(() => httpServiceMock.post(any(), data: any(named: 'data')))
          .called(1);
    });

    test('Return an instance of ApiDataSourceError - 503', () async {
      when(() => httpServiceMock.post(any(), data: any(named: 'data')))
          .thenThrow(
        DioError(
          requestOptions: requestOptions,
          response: Response(
            statusCode: HttpStatus.serviceUnavailable,
            requestOptions: requestOptions,
          ),
        ),
      );
      final response = datasource(params);
      expect(() => response, throwsA(isA<ApiDataSourceError>()));
      verify(() => httpServiceMock.post(any(), data: any(named: 'data')))
          .called(1);
    });

    test('Return an error of ApiDataSourceError', () async {
      when(() => httpServiceMock.post(any(), data: any(named: 'data')))
          .thenThrow(
        DioError(
          requestOptions: requestOptions,
          response: Response(
            statusCode: HttpStatus.internalServerError,
            data: {'message': 'Request Error'},
            requestOptions: requestOptions,
          ),
        ),
      );

      final response = datasource(params);
      expect(() => response, throwsA(isA<ApiDataSourceError>()));
      verify(() => httpServiceMock.post(any(), data: any(named: 'data')))
          .called(1);
    });

    test('Return an error of SocketExceptionError', () async {
      when(() => httpServiceMock.post(any(), data: any(named: 'data')))
          .thenThrow(
        DioError(
          requestOptions: requestOptions,
          type: DioErrorType.connectTimeout,
          error: 'Connection Failed',
        ),
      );

      final result = datasource(params);
      expect(() => result, throwsA(isA<SocketExceptionError>()));
      verify(() => httpServiceMock.post(any(), data: any(named: 'data')))
          .called(1);
    });

    test('Return an error of DataSourceError', () async {
      final exception = Exception('DataSourceErrorTest');
      when(() => httpServiceMock.post(any(), data: any(named: 'data')))
          .thenThrow(exception);

      final response = datasource(params);
      expect(() => response, throwsA(isA<DataSourceError>()));
      verify(() => httpServiceMock.post(any(), data: any(named: 'data')))
          .called(1);
    });
  });
}

final payload = {
  'result': {
    'name': 'Thiago',
    'email': 'teste@teste.com',
    'token': 'r:a15074e827c86a1dd4db1a386d8ba515',
    'pokemonList': [
      {
        'name': 'bulbasaur',
        'pokemonId': 1,
        'isShiny': false,
        'spriteUrl':
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
        'stats': [
          {'name': 'hp', 'statValue': 45},
          {'name': 'attack', 'statValue': 49},
          {'name': 'defense', 'statValue': 49},
          {'name': 'special-attack', 'statValue': 65},
          {'name': 'special-defense', 'statValue': 65},
          {'name': 'speed', 'statValue': 45}
        ],
        'types': [
          {'name': 'grass', 'color': '7AC74C'},
          {'name': 'poison', 'color': 'A33EA1'}
        ]
      }
    ]
  }
};
