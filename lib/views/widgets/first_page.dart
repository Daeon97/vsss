// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsss/cubits/user_cubit/user_cubit.dart';
import 'package:vsss/resources/colors.dart';
import 'package:vsss/resources/numbers.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/views/widgets/screen_scaffold.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({
    required PageController pageController,
    super.key,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late final GlobalKey<FormState> _formKey;
  String? _name;
  String? _courseOfStudy;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ScreenScaffold(
        useScaffold: false,
        child: Column(
          children: [
            Image.asset(
              helloIllustrationPath,
            ),
            Text(
              helloLiteral,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: smallSpacing,
            ),
            const Text(
              whatIsYourNameAndCourseOfStudyLiteral,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: spacing,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  BlocBuilder<UserCubit, UserState>(
                    builder: (_, userState) => TextFormField(
                      initialValue: userState.user?.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: nameLiteral,
                      ),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return nameFieldCannotBeEmptyLiteral;
                        }
                        return null;
                      },
                      onChanged: (value) => _name = value,
                    ),
                  ),
                  const SizedBox(
                    height: spacing,
                  ),
                  BlocBuilder<UserCubit, UserState>(
                    builder: (_, userState) => DropdownButtonFormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: courseOfStudyLiteral,
                      ),
                      value: userState.user?.courseOfStudy,
                      items: List.generate(
                        courseOfStudyDropdownItemCount,
                        (index) => DropdownMenuItem(
                          value: switch (index) {
                            zero => computerScienceLiteral,
                            one => massCommunicationLiteral,
                            _ => economicsLiteral
                          },
                          child: Text(
                            switch (index) {
                              zero => computerScienceLiteral,
                              one => massCommunicationLiteral,
                              _ => economicsLiteral
                            },
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return selectCourseOfStudyLiteral;
                        }
                        return null;
                      },
                      onChanged: (value) => _courseOfStudy = value,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: largeSpacing + spacing,
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: ElevatedButton(
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
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<UserCubit>()(
                      name: _name?.trim() ??
                          context.read<UserCubit>().state.user?.name ??
                          emptyString,
                      courseOfStudy: _courseOfStudy?.trim() ??
                          context.read<UserCubit>().state.user?.courseOfStudy ??
                          emptyString,
                    );
                    widget._pageController.nextPage(
                      duration: const Duration(
                        milliseconds:
                            pageViewTransitionAnimationDurationMilliseconds,
                      ),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: const Icon(
                  Icons.navigate_next,
                ),
              ),
            ),
          ],
        ),
      );
}
