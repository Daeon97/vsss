// ignore_for_file: public_member_api_docs

part of 'user_cubit.dart';

final class UserState extends Equatable {
  const UserState({
    this.user,
  });

  final User? user;

  @override
  List<Object?> get props => [
        user,
      ];
}
