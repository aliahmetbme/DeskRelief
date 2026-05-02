import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/exercise_model.dart';

/// Data-layer repository responsible for fetching exercise documents from
/// Firestore using the CDSS-aligned [PainRegion] enum as the filter key.
class ExerciseRepository {
  final FirebaseFirestore _firestore;

  ExerciseRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Fetches all exercises whose [targetRegions] array contains at least one
  /// of the [selectedRegions] values (Firestore arrayContainsAny semantics).
  Future<List<ExerciseModel>> getExercisesForRegions(
      List<PainRegion> selectedRegions) async {
    if (selectedRegions.isEmpty) return [];

    try {
      // Map enum values to their JsonValue string equivalents stored in Firestore.
      // We map granular regions (leftShoulder) to general categories (shoulder)
      // to ensure all relevant exercises are fetched.
      final List<String> regionStrings = selectedRegions
          .map((r) => _mapToClinicalCategory(r.name))
          .toSet()
          .toList();

      final snapshot = await _firestore
          .collection('exercises')
          .where('targetRegions', arrayContainsAny: regionStrings)
          .get();

      return snapshot.docs
          .map((doc) => ExerciseModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Egzersizler yüklenirken bir hata oluştu: $e');
    }
  }

  /// Fetches a single exercise document by its Firestore document [id].
  Future<ExerciseModel?> getExerciseById(String id) async {
    try {
      final doc = await _firestore.collection('exercises').doc(id).get();
      if (!doc.exists || doc.data() == null) return null;
      return ExerciseModel.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      throw Exception('Egzersiz yüklenirken bir hata oluştu: $e');
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
