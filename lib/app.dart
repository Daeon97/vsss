// ignore_for_file: public_member_api_docs, strict_raw_type

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsss/cubits/cache_message_cubit/cache_message_cubit.dart';
import 'package:vsss/cubits/chats_cubit/chats_cubit.dart';
import 'package:vsss/cubits/delete_chat_cubit/delete_chat_cubit.dart';
import 'package:vsss/cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:vsss/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:vsss/cubits/user_cubit/user_cubit.dart';
import 'package:vsss/injection_container.dart';
import 'package:vsss/resources/colors.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/views/screens/chat_screen.dart';
import 'package:vsss/views/screens/home_screen.dart';
import 'package:vsss/views/screens/onboarding_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: _providers,
        child: MaterialApp(
          theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(
              seedColor: baseColor,
              // brightness: Brightness.dark,
            ),
          ),
          onGenerateRoute: _routes,
        ),
      );

  List<BlocProvider> get _providers => [
        BlocProvider<OnboardingCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<ChatsCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<SendMessageCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<DeleteChatCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<CacheMessageCubit>(
          create: (_) => sl(),
        ),
      ];

  Route _routes(RouteSettings settings) => MaterialPageRoute(
        builder: (context) => switch (settings.name) {
          defaultScreenRoute => switch (
                context.read<OnboardingCubit>().state.show) {
              false when context.read<UserCubit>().state.user != null =>
                const HomeScreen(),
              _ => const OnboardingScreen()
            },
          onboardingScreenRoute => const OnboardingScreen(),
          chatScreenRoute => const ChatScreen(),
          homeScreenRoute => const HomeScreen(),
          _ => Container()
        },
      );
}
