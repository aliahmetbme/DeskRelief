import 'package:flutter/material.dart';
import '../../data/services/video_cache_service.dart';

class ExerciseVideoViewModel extends ChangeNotifier {
  final String videoUrl;
  final VideoCacheService _cacheService = VideoCacheService();

  ExerciseVideoViewModel({required this.videoUrl});

  String get cachedVideoUrl => _cacheService.getCachedUrl(videoUrl);
}
