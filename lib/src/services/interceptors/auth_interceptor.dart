import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../shared/storage/i_custom_app_storage.dart';
import '../data/endpoints.dart';
import '../http_service/http_service.dart';

class AuthInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path != Endpoints.login) {
      final storage = GetIt.I.get<ICustomAppStorage>();
      final httpService = GetIt.I.get<IHttpService>();
      final token = await storage.readKey('token');

      final headers = {'X-Parse-Session-Token': '$token'};

      options.headers.addAll(headers);
      httpService.addHeaders(headers: headers);
    }
    return handler.next(options);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.requestOptions.path == Endpoints.login &&
        response.statusCode == 200) {
      final httpService = GetIt.I.get<IHttpService>();
      final storage = GetIt.I.get<ICustomAppStorage>();

      final tokenValue = response.data['result']['token'];

      await storage.saveKey('token', tokenValue);

      final authHeader = {'X-Parse-Session-Token': '$tokenValue'};
      httpService.addHeaders(headers: authHeader);

      debugPrint('/// Headers has been updated \\\\\\');
      debugPrint('-> Authorization added in next requests <-');
    }

    return handler.next(response);
  }
}
