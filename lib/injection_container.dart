// ignore_for_file: public_member_api_docs

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:vsss/cubits/cache_message_cubit/cache_message_cubit.dart';
import 'package:vsss/cubits/chats_cubit/chats_cubit.dart';
import 'package:vsss/cubits/course_recommendations_cubit/course_recommendations_cubit.dart';
import 'package:vsss/cubits/delete_chat_cubit/delete_chat_cubit.dart';
import 'package:vsss/cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:vsss/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:vsss/cubits/user_cubit/user_cubit.dart';
import 'package:vsss/models/chat.dart';
import 'package:vsss/repositories/chat_repository.dart';
import 'package:vsss/repositories/recommendation_repository.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/services/chat_service.dart';
import 'package:vsss/services/recommendation_service.dart';
import 'package:vsss/utils/clients/database_client.dart';
import 'package:vsss/utils/clients/http_client.dart';

final sl = GetIt.I;

void registerServices() {
  sl
    // Blocs
    ..registerFactory(
      OnboardingCubit.new,
    )
    ..registerFactory(
      UserCubit.new,
    )
    ..registerFactory(
      () => ChatsCubit(
        sl(),
      ),
    )
    ..registerFactory(
      () => SendMessageCubit(
        sl(),
      ),
    )
    ..registerFactory(
      () => DeleteChatCubit(
        sl(),
      ),
    )
    ..registerFactory(
      () => CacheMessageCubit(
        sl(),
      ),
    )
    ..registerFactory(
      () => CourseRecommendationsCubit(
        sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImplementation(
        chatOpsService: sl(),
        chatUtilsService: sl(),
      ),
    )
    ..registerLazySingleton<RecommendationRepository>(
      () => CourseRecommendationRepository(
        sl(),
      ),
    )

    // Services
    ..registerLazySingleton<ChatOpsService>(
      () => ChatOpsServiceImplementation(
        httpClient: sl.get(
          instanceName: forChatsInstanceName,
        ),
        databaseClient: sl(),
      ),
    )
    ..registerLazySingleton<ChatUtilsService>(
      () => ChatUtilsServiceImplementation(
        sl(),
      ),
    )
    ..registerLazySingleton<RecommendationService>(
      () => CourseRecommendationService(
        sl.get(
          instanceName: forCourseRecommendationsInstanceName,
        ),
      ),
    )

    // Clients
    ..registerLazySingleton(
      () => HttpClient(
        sl.get(
          instanceName: chatBaseUrlInstanceName,
        ),
      ),
      instanceName: forChatsInstanceName,
    )
    ..registerLazySingleton(
      () => HttpClient(
        sl.get(
          instanceName: courseRecommendationBaseUrlInstanceName,
        ),
      ),
      instanceName: forCourseRecommendationsInstanceName,
    )
    ..registerLazySingleton<DatabaseClient<BoxEvent, Chat>>(
      HiveDatabaseClient.new,
    )
    ..registerLazySingleton<DatabaseClient<BoxEvent, bool>>(
      HiveDatabaseClient.new,
    )

    // Primitives
    ..registerLazySingleton(
      () => chatBaseUrl,
      instanceName: chatBaseUrlInstanceName,
    )
    ..registerLazySingleton(
      () => courseRecommendationBaseUrl,
      instanceName: courseRecommendationBaseUrlInstanceName,
    );
}
