// ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:vsss/resources/numbers.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/utils/enums.dart';

final class HttpClient {
  factory HttpClient() => HttpClient._();

  HttpClient._()
      : _dio = Dio()
          ..options = BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(
              seconds: requestConnectTimeoutSeconds,
            ),
            receiveTimeout: const Duration(
              seconds: requestReceiveTimeoutSeconds,
            ),
            sendTimeout: const Duration(
              seconds: requestSendTimeoutSeconds,
            ),
            headers: {
              contentTypeKey: contentTypeValue,
              acceptKey: acceptValue,
            },
          );

  final Dio _dio;

  // ignore: strict_raw_type
  Future<Response> request({
    required RequestMethod requestMethod,
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) {
    switch (requestMethod) {
      case RequestMethod.get:
        return _dio.get(
          path,
          data: data,
          queryParameters: queryParameters,
        );
      case RequestMethod.post:
        return _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
        );
      case RequestMethod.put:
        return _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
        );
    }
  }
}
