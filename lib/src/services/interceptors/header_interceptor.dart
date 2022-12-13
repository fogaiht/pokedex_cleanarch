import 'package:dio/dio.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const keyApplicationId = 'vJE2H5Tb5crMG6zCW4LHEGaLthCz4EFYVYPduRJJ';
    const keyRestApi = 'kAsL8hpFBCHfS9xcU2RdgjrwjURBNcevJoCPGf4g';
    final additionalHeaders = {
      'X-Parse-Application-Id': keyApplicationId,
      'X-Parse-REST-API-Key': keyRestApi,
    };
    options.headers.addAll(additionalHeaders);
    return handler.next(options);
  }
}
