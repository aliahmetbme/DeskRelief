import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../../features/content/domain/models/content_models.dart';

class ContentService {
  static final ContentService _instance = ContentService._internal();
  factory ContentService() => _instance;
  ContentService._internal();

  List<MotivationModel> _motivations = [];
  Map<String, List<ErgoTipModel>> _regionalTips = {};
  List<BlogPostModel> _blogs = [];

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      final String response = await rootBundle.loadString('assets/data/app_content.json');
      final data = json.decode(response);

      // Motivations parsing (hierarchical)
      final motivationsData = data['motivations'] as Map<String, dynamic>;
      _motivations = [];
      motivationsData.forEach((category, list) {
        if (list is List) {
          _motivations.addAll(list.map((m) {
            final model = MotivationModel.fromJson(m);
            return model.copyWith(category: category);
          }).toList());
        }
      });

      // Regional tips parsing
      final tipsData = data['regional_tips'] as Map<String, dynamic>;
      _regionalTips = tipsData.map((key, value) {
        return MapEntry(
          key,
          (value as List).map((t) => ErgoTipModel.fromJson(t)).toList(),
        );
      });

      // Blogs parsing
      _blogs = (data['blogs'] as List)
          .map((b) => BlogPostModel.fromJson(b))
          .toList();

      _isInitialized = true;
    } catch (e) {
      // ignore: avoid_print
      print('Error loading app content: $e');
    }
  }

  MotivationModel? getRandomMotivation(String category) {
    // Check if category is one of the keys or a generic one
    final filtered = _motivations.where((m) => m.category == category).toList();
    if (filtered.isEmpty) return null;
    return filtered[Random().nextInt(filtered.length)];
  }

  List<ErgoTipModel> getTipsForUser(List<String> regionIds) {
    final List<ErgoTipModel> tips = [];
    // Map old region IDs to new JSON keys if necessary
    // But for now, assuming regionIds match the JSON keys (neck_cervical, etc.)
    for (final id in regionIds) {
      // Direct match
      if (_regionalTips.containsKey(id)) {
        tips.addAll(_regionalTips[id]!);
      }
      
      // Fallback/Legacy mapping (if regionIds are still 'neck', 'back', etc.)
      final legacyMapping = {
        'neck': 'neck_cervical',
        'shoulder': 'shoulder_upper_back',
        'back': 'lumbar_pelvis', // or both?
        'waist': 'lumbar_pelvis',
        'hip': 'knee_hip',
        'knee': 'knee_hip',
        'wrist': 'wrist_elbow',
        'elbow': 'wrist_elbow',
      };
      
      final mappedId = legacyMapping[id];
      if (mappedId != null && _regionalTips.containsKey(mappedId)) {
        tips.addAll(_regionalTips[mappedId]!);
      }
    }
    return tips.toSet().toList(); // Remove duplicates if multiple regionIds map to same tip list
  }

  List<BlogPostModel> getFeaturedBlogs() {
    return _blogs;
  }
}
