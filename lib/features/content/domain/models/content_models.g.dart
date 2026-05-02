// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MotivationModel _$MotivationModelFromJson(Map<String, dynamic> json) =>
    _MotivationModel(
      id: json['id'] as String,
      bctFocus: json['bct_focus'] as String?,
      text: Map<String, String>.from(json['text'] as Map),
      category: json['category'] as String? ?? '',
    );

Map<String, dynamic> _$MotivationModelToJson(_MotivationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bct_focus': instance.bctFocus,
      'text': instance.text,
      'category': instance.category,
    };

_ErgoTipModel _$ErgoTipModelFromJson(Map<String, dynamic> json) =>
    _ErgoTipModel(
      id: json['id'] as String,
      rationale: json['rationale'] as String?,
      content: Map<String, String>.from(json['content'] as Map),
    );

Map<String, dynamic> _$ErgoTipModelToJson(_ErgoTipModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rationale': instance.rationale,
      'content': instance.content,
    };

_BlogPostModel _$BlogPostModelFromJson(Map<String, dynamic> json) =>
    _BlogPostModel(
      id: json['id'] as String,
      category: json['category'] as String,
      imageUrl: json['image_url'] as String,
      title: Map<String, String>.from(json['title'] as Map),
      summary: Map<String, String>.from(json['summary'] as Map),
      content: Map<String, String>.from(json['content'] as Map),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$BlogPostModelToJson(_BlogPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'image_url': instance.imageUrl,
      'title': instance.title,
      'summary': instance.summary,
      'content': instance.content,
      'tags': instance.tags,
    };
