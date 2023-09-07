// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vsss/models/failure.dart';
import 'package:vsss/models/video.dart';
import 'package:vsss/repositories/recommendation_repository.dart';

part 'course_recommendations_state.dart';

class CourseRecommendationsCubit extends Cubit<CourseRecommendationsState> {
  CourseRecommendationsCubit(
    RecommendationRepository recommendationRepository,
  )   : _recommendationRepository = recommendationRepository,
        super(
          const CourseRecommendationsInitialState(),
        );

  final RecommendationRepository _recommendationRepository;

  Future<void> getRecommendations(
    String courseOfStudy,
  ) async {
    emit(
      const LoadingCourseRecommendationsState(),
    );
    final result = await _recommendationRepository.getRecommendations(
      courseOfStudy,
    );
    result.fold(
      _failure,
      _video,
    );
  }

  void _failure(
    Failure failure,
  ) =>
      emit(
        FailedToLoadCourseRecommendationsState(
          failure,
        ),
      );

  void _video(
    Video video,
  ) =>
      emit(
        LoadedCourseRecommendationsState(
          video,
        ),
      );
}
