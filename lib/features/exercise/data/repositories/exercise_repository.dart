import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/app_failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/models/exercise_model.dart';

/// Data-layer repository responsible for fetching exercise documents from
/// Firestore using the CDSS-aligned [PainRegion] enum as the filter key.
///
/// Tüm public metotlar [Result<T>] döner — çağıran taraf (ViewModel)
/// `switch` ile başarı/hata durumlarını tip-güvenli şekilde işler.
class ExerciseRepository {
  final FirebaseFirestore _firestore;

  /// Type-safe Firestore collection referansı.
  late final CollectionReference<ExerciseModel> _exercisesRef;

  ExerciseRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _exercisesRef = _firestore.collection('exercises').withConverter<ExerciseModel>(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data();
        if (data == null) throw Exception('Document data is null');
        return ExerciseModel.fromJson({...data, 'id': snapshot.id});
      },
      toFirestore: (model, _) => model.toJson(),
    );
  }

  /// Fetches all exercises whose [targetRegions] array contains at least one
  /// of the [selectedRegions] values (Firestore arrayContainsAny semantics).
  ///
  /// [acuteRegionIds]: Kullanıcının akut/flare-up durumundaki bölge ID'leri.
  /// Joker egzersizler (isJoker == true), hedef bölgelerinden herhangi biri
  /// bu listede yer alıyorsa sonuçtan çıkarılır.
  Future<Result<List<ExerciseModel>>> getExercisesForRegions(
    List<PainRegion> selectedRegions, {
    List<String> acuteRegionIds = const [],
  }) async {
    if (selectedRegions.isEmpty) return const Success([]);

    try {
      // Map enum values to their clinical category equivalents stored in Firestore.
      final List<String> regionStrings = selectedRegions
          .map((r) => _mapToClinicalCategory(r.name))
          .toSet()
          .toList();

      final snapshot = await _exercisesRef
          .where('targetRegions', arrayContainsAny: regionStrings)
          .get();

      final results = snapshot.docs
          .map((doc) => doc.data())
          .toList();

      // ──────────────────────────────────────────────────────────────────────
      // Joker Filtresi (Klinik Güvenlik Kuralı)
      // ──────────────────────────────────────────────────────────────────────
      // Eğer bir egzersiz isJoker == true ise VE targetRegions içindeki
      // herhangi bir bölge kullanıcının akut/flare-up listesinde yer alıyorsa,
      // o egzersiz güvenli değildir ve listeden çıkarılır.
      if (acuteRegionIds.isNotEmpty) {
        results.removeWhere((exercise) =>
            exercise.isJoker &&
            exercise.targetRegions.any(
              (region) => acuteRegionIds.contains(
                _mapToClinicalCategory(region.name),
              ),
            ));
      }

      return Success(results);
    } on FirebaseException catch (e) {
      debugPrint('❌ FIRESTORE ERROR [exercises]: ${e.code} - ${e.message}');
      return Failure(FirestoreFailure(
        'Egzersizler yüklenirken bir hata oluştu.',
        e.toString(),
      ));
    } on SocketException catch (e) {
      debugPrint('❌ NETWORK ERROR [exercises]: $e');
      return Failure(NetworkFailure(
        'İnternet bağlantınızı kontrol edin.',
        e.toString(),
      ));
    } catch (e) {
      debugPrint('❌ UNKNOWN ERROR [exercises]: $e');
      return Failure(UnknownFailure(
        'Egzersizler yüklenirken beklenmeyen bir hata oluştu.',
        e.toString(),
      ));
    }
  }

  /// Fetches a single exercise document by its Firestore document [id].
  Future<Result<ExerciseModel?>> getExerciseById(String id) async {
    try {
      final doc = await _exercisesRef.doc(id).get();
      if (!doc.exists) return const Success(null);
      return Success(doc.data());
    } on FirebaseException catch (e) {
      debugPrint('❌ FIRESTORE ERROR [exercise/$id]: ${e.code} - ${e.message}');
      return Failure(FirestoreFailure(
        'Egzersiz yüklenirken bir hata oluştu.',
        e.toString(),
      ));
    } on SocketException catch (e) {
      debugPrint('❌ NETWORK ERROR [exercise/$id]: $e');
      return Failure(NetworkFailure(
        'İnternet bağlantınızı kontrol edin.',
        e.toString(),
      ));
    } catch (e) {
      debugPrint('❌ UNKNOWN ERROR [exercise/$id]: $e');
      return Failure(UnknownFailure(
        'Egzersiz yüklenirken beklenmeyen bir hata oluştu.',
        e.toString(),
      ));
    }
  }

  /// Maps granular lateralized regions to general clinical categories used in Firestore.
  String _mapToClinicalCategory(String regionName) {
    if (regionName.contains('Shoulder')) return 'shoulder';
    if (regionName.contains('Arm')) return 'arm';
    if (regionName.contains('Knee')) return 'knee';
    if (regionName.contains('Ankle')) return 'ankle';
    return regionName; // neck, upperBack, lowerBack, hip remain the same
  }
}
