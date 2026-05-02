import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_models.freezed.dart';
part 'content_models.g.dart';

@freezed
abstract class BlogCitation with _$BlogCitation {
  const factory BlogCitation({
    required String title,
    required String url,
  }) = _BlogCitation;

  factory BlogCitation.fromJson(Map<String, dynamic> json) =>
      _$BlogCitationFromJson(json);
}

@freezed
abstract class MotivationModel with _$MotivationModel {
  const factory MotivationModel({
    required String id,
    @JsonKey(name: 'bct_focus') String? bctFocus,
    required Map<String, String> text,
    @Default('') String category, // Populated during parsing (e.g., 'screen_greetings')
    String? citations,
  }) = _MotivationModel;

  factory MotivationModel.fromJson(Map<String, dynamic> json) =>
      _$MotivationModelFromJson(json);
}

@freezed
abstract class ErgoTipModel with _$ErgoTipModel {
  const factory ErgoTipModel({
    required String id,
    String? rationale,
    Map<String, String>? content, // Used in regional_tips
    Map<String, String>? text,    // Used in ergonomic_micro_interventions
    String? citations,
  }) = _ErgoTipModel;

  factory ErgoTipModel.fromJson(Map<String, dynamic> json) =>
      _$ErgoTipModelFromJson(json);
}

@freezed
abstract class BlogPostModel with _$BlogPostModel {
  const factory BlogPostModel({
    required String id,
    required Map<String, String> category,
    @JsonKey(name: 'image_url') required String imageUrl,
    required Map<String, String> title,
    required Map<String, String> summary,
    required Map<String, String> content,
    List<BlogCitation>? citations,
  }) = _BlogPostModel;

  factory BlogPostModel.fromJson(Map<String, dynamic> json) =>
      _$BlogPostModelFromJson(json);
}


extension MotivationX on MotivationModel {
  String getLocalizedText(String locale) => text[locale] ?? text['en'] ?? '';
}

extension ErgoTipX on ErgoTipModel {
  String getLocalizedContent(String locale) {
    final data = content ?? text;
    if (data == null) return '';
    return data[locale] ?? data['en'] ?? '';
  }
}

extension BlogPostX on BlogPostModel {
  String getLocalizedTitle(String locale) => title[locale] ?? title['en'] ?? '';
  String getLocalizedSummary(String locale) => summary[locale] ?? summary['en'] ?? '';
  String getLocalizedContent(String locale) => content[locale] ?? content['en'] ?? '';
  String getLocalizedCategory(String locale) => category[locale] ?? category['en'] ?? '';
}

