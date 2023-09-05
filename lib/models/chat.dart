// ignore_for_file: public_member_api_docs

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vsss/resources/numbers.dart';

part 'chat.g.dart';

@JsonSerializable()
@HiveType(typeId: zero)
final class Chat extends HiveObject {
  Chat({
    required this.message,
    required this.timestamp,
    this.options,
  });

  factory Chat.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ChatFromJson(
        json,
      );

  @HiveField(zero)
  final String message;

  @JsonKey(required: false)
  @HiveField(one)
  final int timestamp;

  @HiveField(two)
  final List<String>? options;

  Map<String, dynamic> toJson() => _$ChatToJson(
        this,
      );
}
