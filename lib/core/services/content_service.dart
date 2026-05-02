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
  List<ErgoTipModel> _ergoInterventions = [];
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

      // Ergonomic micro-interventions parsing
      if (data['ergonomic_micro_interventions'] != null) {
        _ergoInterventions = (data['ergonomic_micro_interventions'] as List)
            .map((e) => ErgoTipModel.fromJson(e))
            .toList();
      }

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

  ErgoTipModel? getRandomErgoIntervention() {
    if (_ergoInterventions.isEmpty) return null;
    return _ergoInterventions[Random().nextInt(_ergoInterventions.length)];
  }

  ErgoTipModel? getRandomRegionalTip(String regionId) {
    // Try direct match
    if (_regionalTips.containsKey(regionId)) {
      final list = _regionalTips[regionId]!;
      return list[Random().nextInt(list.length)];
    }

    // Try legacy mapping
    final legacyMapping = {
      'neck': 'neck_cervical',
      'shoulder': 'shoulder_upper_back',
      'back': 'lumbar_pelvis',
      'waist': 'lumbar_pelvis',
      'hip': 'knee_hip',
      'knee': 'knee_hip',
      'wrist': 'wrist_elbow',
      'elbow': 'wrist_elbow',
    };

    final mappedId = legacyMapping[regionId];
    if (mappedId != null && _regionalTips.containsKey(mappedId)) {
      final list = _regionalTips[mappedId]!;
      return list[Random().nextInt(list.length)];
    }

    return null;
  }

  List<ErgoTipModel> getTipsForUser(List<String> regionIds) {
    final List<ErgoTipModel> tips = [];
    
    // Always include some general ergonomic micro-interventions
    if (_ergoInterventions.isNotEmpty) {
      // Pick 2 random interventions for variety
      final random = Random();
      final indices = List.generate(_ergoInterventions.length, (i) => i)..shuffle(random);
      tips.addAll(indices.take(2).map((i) => _ergoInterventions[i]));
    }

    // Map region IDs to JSON keys
    for (final id in regionIds) {
      // Direct match
      if (_regionalTips.containsKey(id)) {
        tips.addAll(_regionalTips[id]!);
      }
      
      // Fallback/Legacy mapping (if regionIds are still 'neck', 'back', etc.)
      final legacyMapping = {
        'neck': 'neck_cervical',
        'shoulder': 'shoulder_upper_back',
        'back': 'lumbar_pelvis',
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
    return tips.toSet().toList(); // Remove duplicates
  }

  List<ErgoTipModel> getAllErgoInterventions() {
    return _ergoInterventions;
  }

  List<BlogPostModel> getFeaturedBlogs() {
    return _blogs;
  }
}

