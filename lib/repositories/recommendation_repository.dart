// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vsss/models/failure.dart';
import 'package:vsss/models/video.dart';
import 'package:vsss/resources/numbers.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/services/recommendation_service.dart';

abstract final class RecommendationRepository {
  Future<Either<Failure, Video>> getRecommendations(
    String courseOfStudy,
  );
}

final class CourseRecommendationRepository implements RecommendationRepository {
  const CourseRecommendationRepository(
    RecommendationService recommendationService,
  ) : _recommendationService = recommendationService;

  final RecommendationService _recommendationService;

  @override
  Future<Either<Failure, Video>> getRecommendations(
    String courseOfStudy,
  ) async {
    final transformedCourseOfStudy = courseOfStudy
        .toLowerCase()
        .split(
          whiteSpace,
        )
        .join();
    try {
      final result = await _recommendationService.getRecommendations(
        path: searchPath,
        queryParameters: <String, dynamic>{
          partKey: snippetValue,
          qKey: transformedCourseOfStudy,
          typeKey: videoValue,
          maxResultsKey: maxNumberOfVideosToReturnFromApi,
          keyKey: dotenv.env[youtubeDataApiKey],
        },
      );
      final json = result.data as Map<String, dynamic>;
      final video = Video.fromJson(
        json,
      );
      return Right(
        video,
      );
    } catch (_) {
      return const Left(
        Failure(
          couldNotRetrieveRecommendationsLiteral,
        ),
      );
    }
  }
}
