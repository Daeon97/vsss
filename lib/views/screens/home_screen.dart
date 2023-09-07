// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsss/cubits/course_recommendations_cubit/course_recommendations_cubit.dart';
import 'package:vsss/cubits/user_cubit/user_cubit.dart';
import 'package:vsss/resources/numbers.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/views/widgets/screen_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final user = context.read<UserCubit>().state.user;
    if (user != null) {
      context.read<CourseRecommendationsCubit>().getRecommendations(
            user.courseOfStudy,
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ScreenScaffold(
        useScrollView: false,
        centerViewVertically: false,
        edgeInsetsGeometry: EdgeInsets.zero,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(
            Icons.chat,
          ),
          onPressed: () => Navigator.of(context).pushNamed(
            chatScreenRoute,
          ),
        ),
        child:
            BlocBuilder<CourseRecommendationsCubit, CourseRecommendationsState>(
          builder: (
            _,
            courseRecommendationsState,
          ) =>
              switch (courseRecommendationsState) {
            LoadingCourseRecommendationsState() => SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            LoadedCourseRecommendationsState(
              video: final videoRecommendations,
            ) =>
              ListView.builder(
                shrinkWrap: true,
                itemCount: videoRecommendations.items.length,
                itemBuilder: (_, index) => Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: index == zero ? spacing : nil,
                    bottom: spacing,
                  ),
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(
                      spacing,
                    ),
                    margin: const EdgeInsetsDirectional.symmetric(
                      horizontal: spacing,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadiusDirectional.circular(
                        spacing,
                      ),
                    ),
                    child: Text(
                      videoRecommendations.items[index].snippet.title,
                    ),
                  ),
                ),
              ),
            FailedToLoadCourseRecommendationsState(
              failure: final error,
            ) =>
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      serverDownIllustrationPath,
                    ),
                    const SizedBox(
                      height: spacing,
                    ),
                    Text(
                      error.reason,
                    ),
                  ],
                ),
              ),
            _ => const SizedBox.shrink()
          },
        ),
      );
}
