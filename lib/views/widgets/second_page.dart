// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsss/cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:vsss/resources/numbers.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/views/widgets/screen_scaffold.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({
    required PageController pageController,
    super.key,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) => ScreenScaffold(
        useScaffold: false,
        child: Column(
          children: [
            Image.asset(
              welcomeIllustrationPath,
            ),
            Text(
              welcomeToStudentEaseLiteral,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: smallSpacing,
            ),
            const Text(
              yourPersonalizedVirtualStudentSupportServiceLiteral,
            ),
            const SizedBox(
              height: largeSpacing + spacing,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll<OutlinedBorder>(
                      CircleBorder(),
                    ),
                    padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsetsDirectional.all(
                        spacing,
                      ),
                    ),
                  ),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(
                        milliseconds:
                            pageViewTransitionAnimationDurationMilliseconds,
                      ),
                      curve: Curves.easeIn,
                    );
                  },
                  child: const Icon(
                    Icons.navigate_before,
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll<OutlinedBorder>(
                      CircleBorder(),
                    ),
                    padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsetsDirectional.all(
                        spacing,
                      ),
                    ),
                  ),
                  onPressed: () {
                    context.read<OnboardingCubit>()(
                      show: false,
                    );
                    Navigator.of(context).pushReplacementNamed(
                      homeScreenRoute,
                    );
                  },
                  child: const Icon(
                    Icons.navigate_next,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
