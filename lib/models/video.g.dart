// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'snippet': instance.snippet,
    };

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnails:
          Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'thumbnails': instance.thumbnails,
    };

Thumbnails _$ThumbnailsFromJson(Map<String, dynamic> json) => Thumbnails(
      mDefault: json['default'] == null
          ? null
          : Thumbnail.fromJson(json['default'] as Map<String, dynamic>),
      medium: json['medium'] == null
          ? null
          : Thumbnail.fromJson(json['medium'] as Map<String, dynamic>),
      high: json['high'] == null
          ? null
          : Thumbnail.fromJson(json['high'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ThumbnailsToJson(Thumbnails instance) =>
    <String, dynamic>{
      'default': instance.mDefault,
      'medium': instance.medium,
      'high': instance.high,
    };

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
      url: json['url'] as String,
      width: json['width'] as num?,
      height: json['height'] as num?,
    );

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
