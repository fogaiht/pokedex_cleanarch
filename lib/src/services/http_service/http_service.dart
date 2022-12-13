import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import '../interceptors/export/interceptors.dart';
import '../interceptors/header_interceptor.dart';

class HttpService extends DioForNative implements IHttpService {
  final String baseUrl;

  HttpService(this.baseUrl,
      {required List<Interceptor> additionalInterceptorsList}) {
    assert(baseUrl.isNotEmpty);
    options.baseUrl = baseUrl;
    options.headers.addAll({HttpHeaders.contentTypeHeader: 'application/json'});
    options.headers.addAll({HttpHeaders.acceptHeader: 'application/json'});
    options.setRequestContentTypeWhenNoPayload = true;
    options.connectTimeout = 10000;

    setUpInterceptors(requiredInterceptors: additionalInterceptorsList);
  }

  @override
  void setUpInterceptors({required List<Interceptor> requiredInterceptors}) {
    interceptors.add(InfoInterceptors());
    interceptors.add(ConnectivityInterceptor());
    interceptors.add(HeaderInterceptor());
    interceptors.add(AuthInterceptor());
    interceptors.addAll(requiredInterceptors);
  }

  @override
  void setAuthorization(String token) {
    options.headers.addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
  }

  @override
  void removeAuthorization() {
    options.headers.remove(HttpHeaders.authorizationHeader);
  }

  @override
  void addHeaders({required Map<String, dynamic> headers}) {
    options.headers.addAll(headers);
  }
}

abstract class IHttpService extends DioForNative {
  void setUpInterceptors({required List<Interceptor> requiredInterceptors});
  void setAuthorization(String token);
  void removeAuthorization();
  void addHeaders({required Map<String, dynamic> headers});
}
