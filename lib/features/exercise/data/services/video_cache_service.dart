import 'package:flutter_video_caching/flutter_video_caching.dart';

class VideoCacheService {
  static final VideoCacheService _instance = VideoCacheService._internal();
  factory VideoCacheService() => _instance;
  VideoCacheService._internal();

  /// Sisteme başlatır ve yapılandırır.
  Future<void> init() async {
    // Maksimum önbellek boyutu 500MB
    await VideoProxy.init(
      maxStorageCacheSize: 500 * 1024 * 1024,
    );
  }

  /// Normal bir URL'i önbellekleme sisteminin kullanabileceği bir proxy URL'sine çevirir.
  String getCachedUrl(String url) {
    if (url.isEmpty) return '';
    // Firebase Storage token'ları vb. için URL'yi güvenli hale getiriyoruz
    final encodedUrl = Uri.encodeFull(url);
    return encodedUrl.toLocalUri().toString();
  }
}
