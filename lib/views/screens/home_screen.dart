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
        appBarTitle: BlocBuilder<UserCubit, UserState>(
          builder: (
            _,
            userState,
          ) =>
              Text(
            switch (userState.user) {
              null => homeLiteral,
              _ => helloLiteral +
                  comma +
                  whiteSpace +
                  userState.user!.name
                      .split(
                        RegExp(
                          nameSplitRegexPattern,
                        ),
                      )
                      .first
            },
          ),
        ),
        appBarLeading: Row(
          children: [
            const SizedBox(
              width: spacing,
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
              child: BlocBuilder<UserCubit, UserState>(
                builder: (
                  _,
                  userState,
                ) =>
                    switch (userState.user) {
                  null => Image.asset(
                      avatarIllustrationPath,
                    ),
                  _ => Text(
                      userState.user!.name
                          .split(
                            RegExp(
                              nameSplitRegexPattern,
                            ),
                          )
                          .first
                          .split(
                            emptyString,
                          )
                          .first,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    )
                },
              ),
            ),
          ],
        ),
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
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          height: videoRecommendationsImageHeight,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                videoRecommendations.items[index].snippet
                                        .thumbnails.high?.url ??
                                    videoRecommendations.items[index].snippet
                                        .thumbnails.medium?.url ??
                                    videoRecommendations.items[index].snippet
                                        .thumbnails.mDefault!.url,
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadiusDirectional.vertical(
                              bottom: Radius.circular(
                                spacing,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: smallSpacing,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: spacing,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.title,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                    const SizedBox(
                                      width: smallSpacing,
                                    ),
                                    Expanded(
                                      child: Text(
                                        videoRecommendations
                                            .items[index].snippet.title,
                                        maxLines: three,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: smallSpacing,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: spacing,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.description,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                    const SizedBox(
                                      width: smallSpacing,
                                    ),
                                    Expanded(
                                      child: Text(
                                        videoRecommendations
                                            .items[index].snippet.description,
                                        maxLines: three,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: smallSpacing,
                              ),
                            ],
                          ),
                        ),
                      ],
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
