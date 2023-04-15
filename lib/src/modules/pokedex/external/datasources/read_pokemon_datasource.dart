import 'package:dio/dio.dart';

import '../../../../services/data/endpoints.dart';
import '../../../../services/http_service/http_service.dart';
import '../../../../shared/errors/export/errors.dart';
import '../../pokedex_module.dart';

class ReadPokemonDatasource extends IReadPokemonDatasource {
  final IHttpService httpService;

  ReadPokemonDatasource(this.httpService);
  @override
  Future<ReadPokemonResponse> call(ReadPokemonParams params) async {
    try {
      final response = await httpService.post(
        Endpoints.readPokemon,
        data: params.toBodyRequest(),
      );
      final finalResponse = ReadPokemonResponseMapper.fromJson(
        response.data['result'],
      );

      return finalResponse;
    } on DioError catch (e, s) {
      e.type == DioErrorType.connectTimeout
          ? throw SocketExceptionError(
              message: e.error,
              stackTrace: s,
            )
          : throw ApiDataSourceError.fromError(e.response?.data, s);
    } on DataSourceError {
      rethrow;
    } catch (e, s) {
      throw DataSourceError(message: e.toString(), stackTrace: s);
    }
  }
}
