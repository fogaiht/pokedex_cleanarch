import 'package:dio/dio.dart';

import '../../../../services/data/endpoints.dart';
import '../../../../services/http_service/http_service.dart';
import '../../../../shared/errors/export/errors.dart';
import '../../login_module.dart';

class LoginDatasource extends ILoginDatasource {
  final IHttpService httpService;

  LoginDatasource(this.httpService);
  @override
  Future<LoginResponse> call(LoginParams params) async {
    try {
      final response = await httpService.post(
        Endpoints.login,
        data: params.toBodyRequest(),
      );
      final finalResponse = LoginResponseMapper.fromJson(
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
    } catch (e, s) {
      throw DataSourceError(message: e.toString(), stackTrace: s);
    }
  }
}
