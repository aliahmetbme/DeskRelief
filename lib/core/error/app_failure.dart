library;

/// DeskRelief — Merkezi Hata Tipleri
///
/// Dart 3 `sealed class` ile tip-güvenli hata hiyerarşisi.
/// Repository ve Service katmanlarından fırlatılan hataları
/// sunum katmanında `switch` ile tüketmek için tasarlanmıştır.

sealed class AppFailure {
  final String message;
  final String? debugInfo;
  const AppFailure(this.message, {this.debugInfo});

  @override
  String toString() => 'AppFailure($runtimeType): $message';
}

/// İnternet bağlantısı yok veya sunucu yanıt vermiyor.
class NetworkFailure extends AppFailure {
  const NetworkFailure([
    super.message = 'İnternet bağlantısı kurulamadı.',
    String? debugInfo,
  ]) : super(debugInfo: debugInfo);
}

/// Firebase Auth hatası (giriş, kayıt, token vb.)
class AuthFailure extends AppFailure {
  final String? code;
  const AuthFailure([
    super.message = 'Kimlik doğrulama hatası.',
    this.code,
    String? debugInfo,
  ]) : super(debugInfo: debugInfo);
}

/// Firestore okuma/yazma hatası.
class FirestoreFailure extends AppFailure {
  const FirestoreFailure([
    super.message = 'Veritabanı işlemi başarısız oldu.',
    String? debugInfo,
  ]) : super(debugInfo: debugInfo);
}

/// Beklenmeyen / sınıflandırılamamış hata.
class UnknownFailure extends AppFailure {
  const UnknownFailure([
    super.message = 'Beklenmeyen bir hata oluştu.',
    String? debugInfo,
  ]) : super(debugInfo: debugInfo);
}
