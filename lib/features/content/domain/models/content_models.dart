import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_models.freezed.dart';
part 'content_models.g.dart';

@freezed
abstract class MotivationModel with _$MotivationModel {
  const factory MotivationModel({
    required String id,
    @JsonKey(name: 'bct_focus') String? bctFocus,
    required Map<String, String> text,
    @Default('') String category, // Populated during parsing
  }) = _MotivationModel;

  factory MotivationModel.fromJson(Map<String, dynamic> json) =>
      _$MotivationModelFromJson(json);
}

@freezed
abstract class ErgoTipModel with _$ErgoTipModel {
  const factory ErgoTipModel({
    required String id,
    String? rationale,
    required Map<String, String> content,
  }) = _ErgoTipModel;

  factory ErgoTipModel.fromJson(Map<String, dynamic> json) =>
      _$ErgoTipModelFromJson(json);
}

@freezed
abstract class BlogPostModel with _$BlogPostModel {
  const factory BlogPostModel({
    required String id,
    required String category,
    @JsonKey(name: 'image_url') required String imageUrl,
    required Map<String, String> title,
    required Map<String, String> summary,
    required Map<String, String> content,
    @Default([]) List<String> tags,
  }) = _BlogPostModel;

  factory BlogPostModel.fromJson(Map<String, dynamic> json) =>
      _$BlogPostModelFromJson(json);
}

extension MotivationX on MotivationModel {
  String getLocalizedText(String locale) => text[locale] ?? text['en'] ?? '';
}

extension ErgoTipX on ErgoTipModel {
  String getLocalizedContent(String locale) => content[locale] ?? content['en'] ?? '';
}

extension BlogPostX on BlogPostModel {
  String getLocalizedTitle(String locale) => title[locale] ?? title['en'] ?? '';
  String getLocalizedSummary(String locale) => summary[locale] ?? summary['en'] ?? '';
  String getLocalizedContent(String locale) => content[locale] ?? content['en'] ?? '';
}
