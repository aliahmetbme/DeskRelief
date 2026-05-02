library;

/// DeskRelief — Fonksiyonel Result Wrapper
///
/// `Either<Failure, Success>` pattern'ının Dart 3 native implementasyonu.
/// Harici paket (dartz, fpdart) gerektirmez.
///
/// Kullanım:
/// ```dart
/// final result = await repository.getExercises(regions);
/// switch (result) {
///   case Success(:final data):
///     // data kullan
///   case Failure(:final failure):
///     // failure.message göster
/// }
/// ```
import 'app_failure.dart';

sealed class Result<T> {
  const Result();

  /// Başarılı mı kontrolü.
  bool get isSuccess => this is Success<T>;

  /// Başarısız mı kontrolü.
  bool get isFailure => this is Failure<T>;

  /// Başarılı ise veriyi döner, değilse null.
  T? get dataOrNull => switch (this) {
    Success(:final data) => data,
    Failure() => null,
  };

  /// Başarısız ise hatayı döner, değilse null.
  AppFailure? get failureOrNull => switch (this) {
    Success() => null,
    Failure(:final failure) => failure,
  };

  /// Fonksiyonel map: başarılıysa dönüştür, değilse hatayı taşı.
  Result<R> map<R>(R Function(T data) transform) => switch (this) {
    Success(:final data) => Success(transform(data)),
    Failure(:final failure) => Failure(failure),
  };
}

/// İşlem başarılı — veri taşıyıcı.
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);

  @override
  String toString() => 'Success($data)';
}

/// İşlem başarısız — hata taşıyıcı.
class Failure<T> extends Result<T> {
  final AppFailure failure;
  const Failure(this.failure);

  @override
  String toString() => 'Failure(${failure.message})';
}
