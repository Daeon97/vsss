// ignore_for_file: public_member_api_docs

part of 'course_recommendations_cubit.dart';

abstract final class CourseRecommendationsState extends Equatable {
  const CourseRecommendationsState();
}

final class CourseRecommendationsInitialState
    extends CourseRecommendationsState {
  const CourseRecommendationsInitialState();

  @override
  List<Object?> get props => [];
}

final class LoadingCourseRecommendationsState
    extends CourseRecommendationsState {
  const LoadingCourseRecommendationsState();

  @override
  List<Object?> get props => [];
}

final class LoadedCourseRecommendationsState
    extends CourseRecommendationsState {
  const LoadedCourseRecommendationsState(
    this.video,
  );

  final Video video;

  @override
  List<Object?> get props => [
        video,
      ];
}

final class FailedToLoadCourseRecommendationsState
    extends CourseRecommendationsState {
  const FailedToLoadCourseRecommendationsState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
