// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
import 'package:vsss/resources/strings.dart';

part 'video.g.dart';

@JsonSerializable()
final class Video {
  const Video(
    this.items,
  );

  factory Video.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$VideoFromJson(
        json,
      );

  final List<Item> items;

  Map<String, dynamic> toJson() => _$VideoToJson(
        this,
      );
}

@JsonSerializable()
final class Item {
  const Item(
    this.snippet,
  );

  factory Item.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ItemFromJson(
        json,
      );

  final Snippet snippet;

  Map<String, dynamic> toJson() => _$ItemToJson(
        this,
      );
}

@JsonSerializable()
final class Snippet {
  const Snippet({
    required this.title,
    required this.description,
    required this.thumbnails,
  });

  factory Snippet.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SnippetFromJson(
        json,
      );

  final String title;
  final String description;
  final Thumbnails thumbnails;

  Map<String, dynamic> toJson() => _$SnippetToJson(
        this,
      );
}

@JsonSerializable()
final class Thumbnails {
  const Thumbnails({
    this.mDefault,
    this.medium,
    this.high,
  });

  factory Thumbnails.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ThumbnailsFromJson(
        json,
      );

  @JsonKey(name: defaultKey)
  final Thumbnail? mDefault;

  final Thumbnail? medium;
  final Thumbnail? high;

  Map<String, dynamic> toJson() => _$ThumbnailsToJson(
        this,
      );
}

@JsonSerializable()
final class Thumbnail {
  Thumbnail({
    required this.url,
    this.width,
    this.height,
  });

  factory Thumbnail.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ThumbnailFromJson(
        json,
      );

  final String url;
  final num? width;
  final num? height;

  Map<String, dynamic> toJson() => _$ThumbnailToJson(
        this,
      );
}
