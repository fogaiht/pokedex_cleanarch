import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';

class InfoInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint('REQUEST: [${options.method}] -> PATH: ${options.path}');
    return handler.next(options);
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final request = err.requestOptions;
    debugPrint(
      'ERROR RESPONSE: [${response == null ? '' : response.statusCode}] -> PATH: ${request.path}',
    );

    return handler.next(err);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    debugPrint(
      'RESPONSE: [${response.statusCode}] -> PATH: ${response.requestOptions.path}',
    );

    return handler.next(response);
  }
}
