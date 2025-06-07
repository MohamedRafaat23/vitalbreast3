import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:vitalbreast3/core/network/api_constant.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      responseType: ResponseType.json,
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      validateStatus: (status) {
        return status != null && status < 500;
      },
    );

    dio = Dio(options);

    // Configure SSL certificate handling
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (cert, host, port) {
        return checkInterception(cert, host, port);
      };
      return client;
    };

    // Add interceptors for logging
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  static bool checkInterception(X509Certificate cert, String host, int port) {
    const trustedIssuers = [
      'Trusted Issuer 1',
      'Trusted Issuer 2',
    ];

    return !trustedIssuers.contains(cert.issuer);
  }

  // Helper methods for HTTP requests
  static Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.get(url, queryParameters: queryParameters, options: options);
  }

  static Future<Response> post({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.post(url, data: data, queryParameters: queryParameters, options: options);
  }

  static Future<Response> put({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.put(url, data: data, queryParameters: queryParameters, options: options);
  }

  static Future<Response> delete({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.delete(url, data: data, queryParameters: queryParameters, options: options);
  }
}