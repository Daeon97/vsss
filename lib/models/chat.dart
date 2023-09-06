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
    this.timestamp,
    this.isReply,
    this.failed,
  });

  factory Chat.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ChatFromJson(
        json,
      );

  @HiveField(zero)
  final String message;

  @HiveField(one)
  final int? timestamp;

  @HiveField(two)
  final bool? isReply;

  @HiveField(three)
  final bool? failed;

  Map<String, dynamic> toJson() => _$ChatToJson(
        this,
      );
}
