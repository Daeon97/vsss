// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
final class User {
  const User({
    required this.name,
    required this.courseOfStudy,
  });

  factory User.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$UserFromJson(
        json,
      );

  final String name;
  final String courseOfStudy;

  Map<String, dynamic> toJson() => _$UserToJson(
        this,
      );
}
