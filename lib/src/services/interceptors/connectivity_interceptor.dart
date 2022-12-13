import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ConnectivityInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw DioError(
        type: DioErrorType.connectTimeout,
        error: 'Confirme sua conexão com a internet e tente novamente.',
        requestOptions: options,
      );
    }
    return handler.next(options);
  }
}
