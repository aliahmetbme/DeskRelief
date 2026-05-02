// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseModel implements DiagnosticableTreeMixin {

 String get id; String get name;@JsonKey(fromJson: _safePainRegionList) List<PainRegion> get targetRegions;@JsonKey(unknownEnumValue: ExercisePhase.rom) ExercisePhase get phase; String get description;@JsonKey(fromJson: _safeStringList) List<String> get steps;@JsonKey(fromJson: _safeStringList) List<String> get warnings;@JsonKey(fromJson: _safeStringList) List<String> get tips; int get recommendedSets; int get recommendedReps; String? get videoUrl; String? get imageUrl; bool get isLocked; bool get isJoker; int? get estimatedDurationSeconds;
/// Create a copy of ExerciseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseModelCopyWith<ExerciseModel> get copyWith => _$ExerciseModelCopyWithImpl<ExerciseModel>(this as ExerciseModel, _$identity);

  /// Serializes this ExerciseModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExerciseModel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('targetRegions', targetRegions))..add(DiagnosticsProperty('phase', phase))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('steps', steps))..add(DiagnosticsProperty('warnings', warnings))..add(DiagnosticsProperty('tips', tips))..add(DiagnosticsProperty('recommendedSets', recommendedSets))..add(DiagnosticsProperty('recommendedReps', recommendedReps))..add(DiagnosticsProperty('videoUrl', videoUrl))..add(DiagnosticsProperty('imageUrl', imageUrl))..add(DiagnosticsProperty('isLocked', isLocked))..add(DiagnosticsProperty('isJoker', isJoker))..add(DiagnosticsProperty('estimatedDurationSeconds', estimatedDurationSeconds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.targetRegions, targetRegions)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.steps, steps)&&const DeepCollectionEquality().equals(other.warnings, warnings)&&const DeepCollectionEquality().equals(other.tips, tips)&&(identical(other.recommendedSets, recommendedSets) || other.recommendedSets == recommendedSets)&&(identical(other.recommendedReps, recommendedReps) || other.recommendedReps == recommendedReps)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.isJoker, isJoker) || other.isJoker == isJoker)&&(identical(other.estimatedDurationSeconds, estimatedDurationSeconds) || other.estimatedDurationSeconds == estimatedDurationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(targetRegions),phase,description,const DeepCollectionEquality().hash(steps),const DeepCollectionEquality().hash(warnings),const DeepCollectionEquality().hash(tips),recommendedSets,recommendedReps,videoUrl,imageUrl,isLocked,isJoker,estimatedDurationSeconds);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExerciseModel(id: $id, name: $name, targetRegions: $targetRegions, phase: $phase, description: $description, steps: $steps, warnings: $warnings, tips: $tips, recommendedSets: $recommendedSets, recommendedReps: $recommendedReps, videoUrl: $videoUrl, imageUrl: $imageUrl, isLocked: $isLocked, isJoker: $isJoker, estimatedDurationSeconds: $estimatedDurationSeconds)';
}


}

/// @nodoc
abstract mixin class $ExerciseModelCopyWith<$Res>  {
  factory $ExerciseModelCopyWith(ExerciseModel value, $Res Function(ExerciseModel) _then) = _$ExerciseModelCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(fromJson: _safePainRegionList) List<PainRegion> targetRegions,@JsonKey(unknownEnumValue: ExercisePhase.rom) ExercisePhase phase, String description,@JsonKey(fromJson: _safeStringList) List<String> steps,@JsonKey(fromJson: _safeStringList) List<String> warnings,@JsonKey(fromJson: _safeStringList) List<String> tips, int recommendedSets, int recommendedReps, String? videoUrl, String? imageUrl, bool isLocked, bool isJoker, int? estimatedDurationSeconds
});




}
/// @nodoc
class _$ExerciseModelCopyWithImpl<$Res>
    implements $ExerciseModelCopyWith<$Res> {
  _$ExerciseModelCopyWithImpl(this._self, this._then);

  final ExerciseModel _self;
  final $Res Function(ExerciseModel) _then;

/// Create a copy of ExerciseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? targetRegions = null,Object? phase = null,Object? description = null,Object? steps = null,Object? warnings = null,Object? tips = null,Object? recommendedSets = null,Object? recommendedReps = null,Object? videoUrl = freezed,Object? imageUrl = freezed,Object? isLocked = null,Object? isJoker = null,Object? estimatedDurationSeconds = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,targetRegions: null == targetRegions ? _self.targetRegions : targetRegions // ignore: cast_nullable_to_non_nullable
as List<PainRegion>,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as ExercisePhase,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<String>,warnings: null == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,tips: null == tips ? _self.tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,recommendedSets: null == recommendedSets ? _self.recommendedSets : recommendedSets // ignore: cast_nullable_to_non_nullable
as int,recommendedReps: null == recommendedReps ? _self.recommendedReps : recommendedReps // ignore: cast_nullable_to_non_nullable
as int,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,isJoker: null == isJoker ? _self.isJoker : isJoker // ignore: cast_nullable_to_non_nullable
as bool,estimatedDurationSeconds: freezed == estimatedDurationSeconds ? _self.estimatedDurationSeconds : estimatedDurationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseModel].
extension ExerciseModelPatterns on ExerciseModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseModel value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(fromJson: _safePainRegionList)  List<PainRegion> targetRegions, @JsonKey(unknownEnumValue: ExercisePhase.rom)  ExercisePhase phase,  String description, @JsonKey(fromJson: _safeStringList)  List<String> steps, @JsonKey(fromJson: _safeStringList)  List<String> warnings, @JsonKey(fromJson: _safeStringList)  List<String> tips,  int recommendedSets,  int recommendedReps,  String? videoUrl,  String? imageUrl,  bool isLocked,  bool isJoker,  int? estimatedDurationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseModel() when $default != null:
return $default(_that.id,_that.name,_that.targetRegions,_that.phase,_that.description,_that.steps,_that.warnings,_that.tips,_that.recommendedSets,_that.recommendedReps,_that.videoUrl,_that.imageUrl,_that.isLocked,_that.isJoker,_that.estimatedDurationSeconds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(fromJson: _safePainRegionList)  List<PainRegion> targetRegions, @JsonKey(unknownEnumValue: ExercisePhase.rom)  ExercisePhase phase,  String description, @JsonKey(fromJson: _safeStringList)  List<String> steps, @JsonKey(fromJson: _safeStringList)  List<String> warnings, @JsonKey(fromJson: _safeStringList)  List<String> tips,  int recommendedSets,  int recommendedReps,  String? videoUrl,  String? imageUrl,  bool isLocked,  bool isJoker,  int? estimatedDurationSeconds)  $default,) {final _that = this;
switch (_that) {
case _ExerciseModel():
return $default(_that.id,_that.name,_that.targetRegions,_that.phase,_that.description,_that.steps,_that.warnings,_that.tips,_that.recommendedSets,_that.recommendedReps,_that.videoUrl,_that.imageUrl,_that.isLocked,_that.isJoker,_that.estimatedDurationSeconds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(fromJson: _safePainRegionList)  List<PainRegion> targetRegions, @JsonKey(unknownEnumValue: ExercisePhase.rom)  ExercisePhase phase,  String description, @JsonKey(fromJson: _safeStringList)  List<String> steps, @JsonKey(fromJson: _safeStringList)  List<String> warnings, @JsonKey(fromJson: _safeStringList)  List<String> tips,  int recommendedSets,  int recommendedReps,  String? videoUrl,  String? imageUrl,  bool isLocked,  bool isJoker,  int? estimatedDurationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseModel() when $default != null:
return $default(_that.id,_that.name,_that.targetRegions,_that.phase,_that.description,_that.steps,_that.warnings,_that.tips,_that.recommendedSets,_that.recommendedReps,_that.videoUrl,_that.imageUrl,_that.isLocked,_that.isJoker,_that.estimatedDurationSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExerciseModel with DiagnosticableTreeMixin implements ExerciseModel {
  const _ExerciseModel({required this.id, required this.name, @JsonKey(fromJson: _safePainRegionList) final  List<PainRegion> targetRegions = const [], @JsonKey(unknownEnumValue: ExercisePhase.rom) required this.phase, required this.description, @JsonKey(fromJson: _safeStringList) final  List<String> steps = const [], @JsonKey(fromJson: _safeStringList) final  List<String> warnings = const [], @JsonKey(fromJson: _safeStringList) final  List<String> tips = const [], this.recommendedSets = 2, this.recommendedReps = 10, this.videoUrl, this.imageUrl, this.isLocked = true, this.isJoker = false, this.estimatedDurationSeconds}): _targetRegions = targetRegions,_steps = steps,_warnings = warnings,_tips = tips;
  factory _ExerciseModel.fromJson(Map<String, dynamic> json) => _$ExerciseModelFromJson(json);

@override final  String id;
@override final  String name;
 final  List<PainRegion> _targetRegions;
@override@JsonKey(fromJson: _safePainRegionList) List<PainRegion> get targetRegions {
  if (_targetRegions is EqualUnmodifiableListView) return _targetRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetRegions);
}

@override@JsonKey(unknownEnumValue: ExercisePhase.rom) final  ExercisePhase phase;
@override final  String description;
 final  List<String> _steps;
@override@JsonKey(fromJson: _safeStringList) List<String> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

 final  List<String> _warnings;
@override@JsonKey(fromJson: _safeStringList) List<String> get warnings {
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_warnings);
}

 final  List<String> _tips;
@override@JsonKey(fromJson: _safeStringList) List<String> get tips {
  if (_tips is EqualUnmodifiableListView) return _tips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tips);
}

@override@JsonKey() final  int recommendedSets;
@override@JsonKey() final  int recommendedReps;
@override final  String? videoUrl;
@override final  String? imageUrl;
@override@JsonKey() final  bool isLocked;
@override@JsonKey() final  bool isJoker;
@override final  int? estimatedDurationSeconds;

/// Create a copy of ExerciseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseModelCopyWith<_ExerciseModel> get copyWith => __$ExerciseModelCopyWithImpl<_ExerciseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExerciseModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExerciseModel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('targetRegions', targetRegions))..add(DiagnosticsProperty('phase', phase))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('steps', steps))..add(DiagnosticsProperty('warnings', warnings))..add(DiagnosticsProperty('tips', tips))..add(DiagnosticsProperty('recommendedSets', recommendedSets))..add(DiagnosticsProperty('recommendedReps', recommendedReps))..add(DiagnosticsProperty('videoUrl', videoUrl))..add(DiagnosticsProperty('imageUrl', imageUrl))..add(DiagnosticsProperty('isLocked', isLocked))..add(DiagnosticsProperty('isJoker', isJoker))..add(DiagnosticsProperty('estimatedDurationSeconds', estimatedDurationSeconds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._targetRegions, _targetRegions)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._steps, _steps)&&const DeepCollectionEquality().equals(other._warnings, _warnings)&&const DeepCollectionEquality().equals(other._tips, _tips)&&(identical(other.recommendedSets, recommendedSets) || other.recommendedSets == recommendedSets)&&(identical(other.recommendedReps, recommendedReps) || other.recommendedReps == recommendedReps)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.isJoker, isJoker) || other.isJoker == isJoker)&&(identical(other.estimatedDurationSeconds, estimatedDurationSeconds) || other.estimatedDurationSeconds == estimatedDurationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_targetRegions),phase,description,const DeepCollectionEquality().hash(_steps),const DeepCollectionEquality().hash(_warnings),const DeepCollectionEquality().hash(_tips),recommendedSets,recommendedReps,videoUrl,imageUrl,isLocked,isJoker,estimatedDurationSeconds);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExerciseModel(id: $id, name: $name, targetRegions: $targetRegions, phase: $phase, description: $description, steps: $steps, warnings: $warnings, tips: $tips, recommendedSets: $recommendedSets, recommendedReps: $recommendedReps, videoUrl: $videoUrl, imageUrl: $imageUrl, isLocked: $isLocked, isJoker: $isJoker, estimatedDurationSeconds: $estimatedDurationSeconds)';
}


}

/// @nodoc
abstract mixin class _$ExerciseModelCopyWith<$Res> implements $ExerciseModelCopyWith<$Res> {
  factory _$ExerciseModelCopyWith(_ExerciseModel value, $Res Function(_ExerciseModel) _then) = __$ExerciseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(fromJson: _safePainRegionList) List<PainRegion> targetRegions,@JsonKey(unknownEnumValue: ExercisePhase.rom) ExercisePhase phase, String description,@JsonKey(fromJson: _safeStringList) List<String> steps,@JsonKey(fromJson: _safeStringList) List<String> warnings,@JsonKey(fromJson: _safeStringList) List<String> tips, int recommendedSets, int recommendedReps, String? videoUrl, String? imageUrl, bool isLocked, bool isJoker, int? estimatedDurationSeconds
});




}
/// @nodoc
class __$ExerciseModelCopyWithImpl<$Res>
    implements _$ExerciseModelCopyWith<$Res> {
  __$ExerciseModelCopyWithImpl(this._self, this._then);

  final _ExerciseModel _self;
  final $Res Function(_ExerciseModel) _then;

/// Create a copy of ExerciseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? targetRegions = null,Object? phase = null,Object? description = null,Object? steps = null,Object? warnings = null,Object? tips = null,Object? recommendedSets = null,Object? recommendedReps = null,Object? videoUrl = freezed,Object? imageUrl = freezed,Object? isLocked = null,Object? isJoker = null,Object? estimatedDurationSeconds = freezed,}) {
  return _then(_ExerciseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,targetRegions: null == targetRegions ? _self._targetRegions : targetRegions // ignore: cast_nullable_to_non_nullable
as List<PainRegion>,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as ExercisePhase,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<String>,warnings: null == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,tips: null == tips ? _self._tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,recommendedSets: null == recommendedSets ? _self.recommendedSets : recommendedSets // ignore: cast_nullable_to_non_nullable
as int,recommendedReps: null == recommendedReps ? _self.recommendedReps : recommendedReps // ignore: cast_nullable_to_non_nullable
as int,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,isJoker: null == isJoker ? _self.isJoker : isJoker // ignore: cast_nullable_to_non_nullable
as bool,estimatedDurationSeconds: freezed == estimatedDurationSeconds ? _self.estimatedDurationSeconds : estimatedDurationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
