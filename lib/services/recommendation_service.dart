// ignore: lines_longer_than_80_chars
// ignore_for_file: public_member_api_docs, strict_raw_type, one_member_abstracts

import 'package:dio/dio.dart';
import 'package:vsss/utils/clients/http_client.dart';
import 'package:vsss/utils/enums.dart';

abstract final class RecommendationService {
  Future<Response> getRecommendations({
    required String path,
    required Map<String, dynamic> queryParameters,
  });
}

final class CourseRecommendationService implements RecommendationService {
  const CourseRecommendationService(
    HttpClient httpClient,
  ) : _httpClient = httpClient;

  final HttpClient _httpClient;

  @override
  Future<Response> getRecommendations({
    required String path,
    required Map<String, dynamic> queryParameters,
  }) =>
      _httpClient.request(
        requestMethod: RequestMethod.get,
        path: path,
        queryParameters: queryParameters,
      );
}
