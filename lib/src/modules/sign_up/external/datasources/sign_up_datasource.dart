import 'package:dio/dio.dart';

import '../../../../services/data/endpoints.dart';
import '../../../../services/http_service/http_service.dart';
import '../../../../shared/errors/export/errors.dart';
import '../../sign_up_module.dart';

class SignUpDatasource extends ISignUpDatasource {
  final IHttpService httpService;

  SignUpDatasource(this.httpService);
  @override
  Future<SignUpResponse> call(SignUpParams params) async {
    try {
      final response = await httpService.post(
        Endpoints.signUp,
        data: params.toBodyRequest(),
      );
      final finalResponse = SignUpResponseMapper.fromJson(
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
