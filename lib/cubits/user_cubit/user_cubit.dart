// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:vsss/models/user.dart';

part 'user_state.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit()
      : super(
          const UserState(),
        );

  void call({
    required String name,
    required String courseOfStudy,
  }) =>
      emit(
        UserState(
          user: User(
            name: name,
            courseOfStudy: courseOfStudy,
          ),
        ),
      );

  @override
  UserState? fromJson(
    Map<String, dynamic> json,
  ) {
    try {
      final user = User.fromJson(json);
      return UserState(
        user: user,
      );
    } catch (_) {
      return const UserState();
    }
  }

  @override
  Map<String, dynamic>? toJson(
    UserState state,
  ) =>
      state.user?.toJson();
}
