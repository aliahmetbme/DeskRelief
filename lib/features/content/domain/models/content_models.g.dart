// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BlogCitation _$BlogCitationFromJson(Map<String, dynamic> json) =>
    _BlogCitation(title: json['title'] as String, url: json['url'] as String);

Map<String, dynamic> _$BlogCitationToJson(_BlogCitation instance) =>
    <String, dynamic>{'title': instance.title, 'url': instance.url};

_MotivationModel _$MotivationModelFromJson(Map<String, dynamic> json) =>
    _MotivationModel(
      id: json['id'] as String,
      bctFocus: json['bct_focus'] as String?,
      text: Map<String, String>.from(json['text'] as Map),
      category: json['category'] as String? ?? '',
      citations: json['citations'] as String?,
    );

Map<String, dynamic> _$MotivationModelToJson(_MotivationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bct_focus': instance.bctFocus,
      'text': instance.text,
      'category': instance.category,
      'citations': instance.citations,
    };

_ErgoTipModel _$ErgoTipModelFromJson(Map<String, dynamic> json) =>
    _ErgoTipModel(
      id: json['id'] as String,
      rationale: json['rationale'] as String?,
      content: (json['content'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      text: (json['text'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      citations: json['citations'] as String?,
    );

Map<String, dynamic> _$ErgoTipModelToJson(_ErgoTipModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rationale': instance.rationale,
      'content': instance.content,
      'text': instance.text,
      'citations': instance.citations,
    };

_BlogPostModel _$BlogPostModelFromJson(Map<String, dynamic> json) =>
    _BlogPostModel(
      id: json['id'] as String,
      category: Map<String, String>.from(json['category'] as Map),
      imageUrl: json['image_url'] as String,
      title: Map<String, String>.from(json['title'] as Map),
      summary: Map<String, String>.from(json['summary'] as Map),
      content: Map<String, String>.from(json['content'] as Map),
      citations: (json['citations'] as List<dynamic>?)
          ?.map((e) => BlogCitation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlogPostModelToJson(_BlogPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'image_url': instance.imageUrl,
      'title': instance.title,
      'summary': instance.summary,
      'content': instance.content,
      'citations': instance.citations?.map((e) => e.toJson()).toList(),
    };
