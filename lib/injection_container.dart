// ignore_for_file: public_member_api_docs

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:vsss/cubits/chats_cubit/chats_cubit.dart';
import 'package:vsss/cubits/message_cubit/message_cubit.dart';
import 'package:vsss/cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:vsss/cubits/user_cubit/user_cubit.dart';
import 'package:vsss/models/chat.dart';
import 'package:vsss/repositories/chat_repository.dart';
import 'package:vsss/services/chat_service.dart';
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
      () => MessageCubit(
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

    // Services
    ..registerLazySingleton<ChatOpsService>(
      () => ChatOpsServiceImplementation(
        httpClient: sl(),
        databaseClient: sl(),
      ),
    )
    ..registerLazySingleton<ChatUtilsService>(
      () => ChatUtilsServiceImplementation(
        sl(),
      ),
    )

    // Clients
    ..registerLazySingleton(
      HttpClient.new,
    )
    ..registerLazySingleton<DatabaseClient<BoxEvent, Chat>>(
      HiveDatabaseClient.new,
    )
    ..registerLazySingleton<DatabaseClient<BoxEvent, bool>>(
      HiveDatabaseClient.new,
    );
}
