// ignore_for_file: public_member_api_docs

import 'package:get_it/get_it.dart';
import 'package:vsss/cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:vsss/cubits/user_cubit/user_cubit.dart';

final sl = GetIt.I;

void registerServices() {
  sl
    // Blocs
    ..registerFactory(
      OnboardingCubit.new,
    )
    ..registerFactory(
      UserCubit.new,
    );
  //
  // // Repositories
  //   ..registerLazySingleton<TrackerModuleRepository>(
  //         () => TrackerModuleRepositoryImplementation(
  //       trackerModuleRemoteDataSource: sl(),
  //     ),
  //   )
  //   ..registerLazySingleton<ThemeRepository>(
  //         () => ThemeRepositoryImplementation(
  //       themeDataSource: sl(),
  //     ),
  //   )
  //
  // // Data sources
  //   ..registerLazySingleton<TrackerModuleRemoteDataSource>(
  //     TrackerModuleRemoteDataSourceImplementation.new,
  //   )
  //   ..registerLazySingleton<ThemeDataSource>(
  //     ThemeDataSourceImplementation.new,
  //   );
}
