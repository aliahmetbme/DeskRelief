import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/exercise_model.dart';

/// Data-layer repository responsible for fetching exercise documents from
/// Firestore using the CDSS-aligned [PainRegion] enum as the filter key.
///
/// Firestore document schema (exercises collection):
/// ```
/// {
///   "id": "exercise_001",
///   "name": "Boyun Lateral Fleksiyonu",
///   "targetRegions": ["neck", "shoulder"],   // PainRegion.name values
///   "phase": "rom",                           // ExercisePhase JsonValue
///   "description": "...",
///   "steps": [...],
///   "warnings": [...],
///   "tips": [...],
///   "recommendedSets": 3,
///   "recommendedReps": 12,
///   "videoUrl": "https://...",
///   "imageUrl": "https://...",
///   "isLocked": false,
///   "isJoker": false
/// }
/// ```
class ExerciseRepository {
  final FirebaseFirestore _firestore;

  ExerciseRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Fetches all exercises whose [targetRegions] array contains at least one
  /// of the [selectedRegions] values (Firestore arrayContainsAny semantics).
  ///
  /// The [selectedRegions] list is produced by [BodyMapViewModel.selectedPainRegions]
  /// which already deduplicates and canonicalises the UI selections.
  ///
  /// Note: Firestore limits arrayContainsAny to 30 values; [PainRegion] has 8
  /// so this is always within bounds.
  Future<List<ExerciseModel>> getExercisesForRegions(
      List<PainRegion> selectedRegions) async {
    if (selectedRegions.isEmpty) return [];

    try {
      // Map enum values to their JsonValue string equivalents stored in Firestore.
      final List<String> regionStrings =
          selectedRegions.map((r) => r.name).toList();

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
}
