// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegistrationProgress {

 bool get hasCompletedWelcome; bool get hasCompletedRedFlags; bool get hasCompletedBodyMap; bool get hasCompletedPainScore; bool get hasCompletedScheduling; bool get isClearedForExercise;
/// Create a copy of RegistrationProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationProgressCopyWith<RegistrationProgress> get copyWith => _$RegistrationProgressCopyWithImpl<RegistrationProgress>(this as RegistrationProgress, _$identity);

  /// Serializes this RegistrationProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationProgress&&(identical(other.hasCompletedWelcome, hasCompletedWelcome) || other.hasCompletedWelcome == hasCompletedWelcome)&&(identical(other.hasCompletedRedFlags, hasCompletedRedFlags) || other.hasCompletedRedFlags == hasCompletedRedFlags)&&(identical(other.hasCompletedBodyMap, hasCompletedBodyMap) || other.hasCompletedBodyMap == hasCompletedBodyMap)&&(identical(other.hasCompletedPainScore, hasCompletedPainScore) || other.hasCompletedPainScore == hasCompletedPainScore)&&(identical(other.hasCompletedScheduling, hasCompletedScheduling) || other.hasCompletedScheduling == hasCompletedScheduling)&&(identical(other.isClearedForExercise, isClearedForExercise) || other.isClearedForExercise == isClearedForExercise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasCompletedWelcome,hasCompletedRedFlags,hasCompletedBodyMap,hasCompletedPainScore,hasCompletedScheduling,isClearedForExercise);

@override
String toString() {
  return 'RegistrationProgress(hasCompletedWelcome: $hasCompletedWelcome, hasCompletedRedFlags: $hasCompletedRedFlags, hasCompletedBodyMap: $hasCompletedBodyMap, hasCompletedPainScore: $hasCompletedPainScore, hasCompletedScheduling: $hasCompletedScheduling, isClearedForExercise: $isClearedForExercise)';
}


}

/// @nodoc
abstract mixin class $RegistrationProgressCopyWith<$Res>  {
  factory $RegistrationProgressCopyWith(RegistrationProgress value, $Res Function(RegistrationProgress) _then) = _$RegistrationProgressCopyWithImpl;
@useResult
$Res call({
 bool hasCompletedWelcome, bool hasCompletedRedFlags, bool hasCompletedBodyMap, bool hasCompletedPainScore, bool hasCompletedScheduling, bool isClearedForExercise
});




}
/// @nodoc
class _$RegistrationProgressCopyWithImpl<$Res>
    implements $RegistrationProgressCopyWith<$Res> {
  _$RegistrationProgressCopyWithImpl(this._self, this._then);

  final RegistrationProgress _self;
  final $Res Function(RegistrationProgress) _then;

/// Create a copy of RegistrationProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasCompletedWelcome = null,Object? hasCompletedRedFlags = null,Object? hasCompletedBodyMap = null,Object? hasCompletedPainScore = null,Object? hasCompletedScheduling = null,Object? isClearedForExercise = null,}) {
  return _then(_self.copyWith(
hasCompletedWelcome: null == hasCompletedWelcome ? _self.hasCompletedWelcome : hasCompletedWelcome // ignore: cast_nullable_to_non_nullable
as bool,hasCompletedRedFlags: null == hasCompletedRedFlags ? _self.hasCompletedRedFlags : hasCompletedRedFlags // ignore: cast_nullable_to_non_nullable
as bool,hasCompletedBodyMap: null == hasCompletedBodyMap ? _self.hasCompletedBodyMap : hasCompletedBodyMap // ignore: cast_nullable_to_non_nullable
as bool,hasCompletedPainScore: null == hasCompletedPainScore ? _self.hasCompletedPainScore : hasCompletedPainScore // ignore: cast_nullable_to_non_nullable
as bool,hasCompletedScheduling: null == hasCompletedScheduling ? _self.hasCompletedScheduling : hasCompletedScheduling // ignore: cast_nullable_to_non_nullable
as bool,isClearedForExercise: null == isClearedForExercise ? _self.isClearedForExercise : isClearedForExercise // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RegistrationProgress].
extension RegistrationProgressPatterns on RegistrationProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegistrationProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegistrationProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegistrationProgress value)  $default,){
final _that = this;
switch (_that) {
case _RegistrationProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegistrationProgress value)?  $default,){
final _that = this;
switch (_that) {
case _RegistrationProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasCompletedWelcome,  bool hasCompletedRedFlags,  bool hasCompletedBodyMap,  bool hasCompletedPainScore,  bool hasCompletedScheduling,  bool isClearedForExercise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegistrationProgress() when $default != null:
return $default(_that.hasCompletedWelcome,_that.hasCompletedRedFlags,_that.hasCompletedBodyMap,_that.hasCompletedPainScore,_that.hasCompletedScheduling,_that.isClearedForExercise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasCompletedWelcome,  bool hasCompletedRedFlags,  bool hasCompletedBodyMap,  bool hasCompletedPainScore,  bool hasCompletedScheduling,  bool isClearedForExercise)  $default,) {final _that = this;
switch (_that) {
case _RegistrationProgress():
return $default(_that.hasCompletedWelcome,_that.hasCompletedRedFlags,_that.hasCompletedBodyMap,_that.hasCompletedPainScore,_that.hasCompletedScheduling,_that.isClearedForExercise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasCompletedWelcome,  bool hasCompletedRedFlags,  bool hasCompletedBodyMap,  bool hasCompletedPainScore,  bool hasCompletedScheduling,  bool isClearedForExercise)?  $default,) {final _that = this;
switch (_that) {
case _RegistrationProgress() when $default != null:
return $default(_that.hasCompletedWelcome,_that.hasCompletedRedFlags,_that.hasCompletedBodyMap,_that.hasCompletedPainScore,_that.hasCompletedScheduling,_that.isClearedForExercise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegistrationProgress implements RegistrationProgress {
  const _RegistrationProgress({this.hasCompletedWelcome = false, this.hasCompletedRedFlags = false, this.hasCompletedBodyMap = false, this.hasCompletedPainScore = false, this.hasCompletedScheduling = false, this.isClearedForExercise = false});
  factory _RegistrationProgress.fromJson(Map<String, dynamic> json) => _$RegistrationProgressFromJson(json);

@override@JsonKey() final  bool hasCompletedWelcome;
@override@JsonKey() final  bool hasCompletedRedFlags;
@override@JsonKey() final  bool hasCompletedBodyMap;
@override@JsonKey() final  bool hasCompletedPainScore;
@override@JsonKey() final  bool hasCompletedScheduling;
@override@JsonKey() final  bool isClearedForExercise;

/// Create a copy of RegistrationProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationProgressCopyWith<_RegistrationProgress> get copyWith => __$RegistrationProgressCopyWithImpl<_RegistrationProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegistrationProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegistrationProgress&&(identical(other.hasCompletedWelcome, hasCompletedWelcome) || other.hasCompletedWelcome == hasCompletedWelcome)&&(identical(other.hasCompletedRedFlags, hasCompletedRedFlags) || other.hasCompletedRedFlags == hasCompletedRedFlags)&&(identical(other.hasCompletedBodyMap, hasCompletedBodyMap) || other.hasCompletedBodyMap == hasCompletedBodyMap)&&(identical(other.hasCompletedPainScore, hasCompletedPainScore) || other.hasCompletedPainScore == hasCompletedPainScore)&&(identical(other.hasCompletedScheduling, hasCompletedScheduling) || other.hasCompletedScheduling == hasCompletedScheduling)&&(identical(other.isClearedForExercise, isClearedForExercise) || other.isClearedForExercise == isClearedForExercise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasCompletedWelcome,hasCompletedRedFlags,hasCompletedBodyMap,hasCompletedPainScore,hasCompletedScheduling,isClearedForExercise);

@override
String toString() {
  return 'RegistrationProgress(hasCompletedWelcome: $hasCompletedWelcome, hasCompletedRedFlags: $hasCompletedRedFlags, hasCompletedBodyMap: $hasCompletedBodyMap, hasCompletedPainScore: $hasCompletedPainScore, hasCompletedScheduling: $hasCompletedScheduling, isClearedForExercise: $isClearedForExercise)';
}


}

/// @nodoc
abstract mixin class _$RegistrationProgressCopyWith<$Res> implements $RegistrationProgressCopyWith<$Res> {
  factory _$RegistrationProgressCopyWith(_RegistrationProgress value, $Res Function(_RegistrationProgress) _then) = __$RegistrationProgressCopyWithImpl;
@override @useResult
$Res call({
 bool hasCompletedWelcome, bool hasCompletedRedFlags, bool hasCompletedBodyMap, bool hasCompletedPainScore, bool hasCompletedScheduling, bool isClearedForExercise
});




}
/// @nodoc
class __$RegistrationProgressCopyWithImpl<$Res>
    implements _$RegistrationProgressCopyWith<$Res> {
  __$RegistrationProgressCopyWithImpl(this._self, this._then);

  final _RegistrationProgress _self;
  final $Res Function(_RegistrationProgress) _then;

/// Create a copy of RegistrationProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasCompletedWelcome = null,Object? hasCompletedRedFlags = null,Object? hasCompletedBodyMap = null,Object? hasCompletedPainScore = null,Object? hasCompletedScheduling = null,Object? isClearedForExercise = null,}) {
  return _then(_RegistrationProgress(
hasCompletedWelcome: null == hasCompletedWelcome ? _self.hasCompletedWelcome : hasCompletedWelcome // ignore: cast_nullable_to_non_nullable
as bool,hasCompletedRedFlags: null == hasCompletedRedFlags ? _self.hasCompletedRedFlags : hasCompletedRedFlags // ignore: cast_nullable_to_non_nullable
as bool,hasCompletedBodyMap: null == hasCompletedBodyMap ? _self.hasCompletedBodyMap : hasCompletedBodyMap // ignore: cast_nullable_to_non_nullable
as bool,hasCompletedPainScore: null == hasCompletedPainScore ? _self.hasCompletedPainScore : hasCompletedPainScore // ignore: cast_nullable_to_non_nullable
as bool,hasCompletedScheduling: null == hasCompletedScheduling ? _self.hasCompletedScheduling : hasCompletedScheduling // ignore: cast_nullable_to_non_nullable
as bool,isClearedForExercise: null == isClearedForExercise ? _self.isClearedForExercise : isClearedForExercise // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$RegionDetail {

 String get regionId; int get nprsScore; int get flareUpCount;@TimestampConverter() DateTime? get lastFlareUpDate; bool get isAkut; List<int> get scoreHistory;
/// Create a copy of RegionDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionDetailCopyWith<RegionDetail> get copyWith => _$RegionDetailCopyWithImpl<RegionDetail>(this as RegionDetail, _$identity);

  /// Serializes this RegionDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionDetail&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.nprsScore, nprsScore) || other.nprsScore == nprsScore)&&(identical(other.flareUpCount, flareUpCount) || other.flareUpCount == flareUpCount)&&(identical(other.lastFlareUpDate, lastFlareUpDate) || other.lastFlareUpDate == lastFlareUpDate)&&(identical(other.isAkut, isAkut) || other.isAkut == isAkut)&&const DeepCollectionEquality().equals(other.scoreHistory, scoreHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,nprsScore,flareUpCount,lastFlareUpDate,isAkut,const DeepCollectionEquality().hash(scoreHistory));

@override
String toString() {
  return 'RegionDetail(regionId: $regionId, nprsScore: $nprsScore, flareUpCount: $flareUpCount, lastFlareUpDate: $lastFlareUpDate, isAkut: $isAkut, scoreHistory: $scoreHistory)';
}


}

/// @nodoc
abstract mixin class $RegionDetailCopyWith<$Res>  {
  factory $RegionDetailCopyWith(RegionDetail value, $Res Function(RegionDetail) _then) = _$RegionDetailCopyWithImpl;
@useResult
$Res call({
 String regionId, int nprsScore, int flareUpCount,@TimestampConverter() DateTime? lastFlareUpDate, bool isAkut, List<int> scoreHistory
});




}
/// @nodoc
class _$RegionDetailCopyWithImpl<$Res>
    implements $RegionDetailCopyWith<$Res> {
  _$RegionDetailCopyWithImpl(this._self, this._then);

  final RegionDetail _self;
  final $Res Function(RegionDetail) _then;

/// Create a copy of RegionDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionId = null,Object? nprsScore = null,Object? flareUpCount = null,Object? lastFlareUpDate = freezed,Object? isAkut = null,Object? scoreHistory = null,}) {
  return _then(_self.copyWith(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as String,nprsScore: null == nprsScore ? _self.nprsScore : nprsScore // ignore: cast_nullable_to_non_nullable
as int,flareUpCount: null == flareUpCount ? _self.flareUpCount : flareUpCount // ignore: cast_nullable_to_non_nullable
as int,lastFlareUpDate: freezed == lastFlareUpDate ? _self.lastFlareUpDate : lastFlareUpDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isAkut: null == isAkut ? _self.isAkut : isAkut // ignore: cast_nullable_to_non_nullable
as bool,scoreHistory: null == scoreHistory ? _self.scoreHistory : scoreHistory // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionDetail].
extension RegionDetailPatterns on RegionDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionDetail value)  $default,){
final _that = this;
switch (_that) {
case _RegionDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionDetail value)?  $default,){
final _that = this;
switch (_that) {
case _RegionDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String regionId,  int nprsScore,  int flareUpCount, @TimestampConverter()  DateTime? lastFlareUpDate,  bool isAkut,  List<int> scoreHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionDetail() when $default != null:
return $default(_that.regionId,_that.nprsScore,_that.flareUpCount,_that.lastFlareUpDate,_that.isAkut,_that.scoreHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String regionId,  int nprsScore,  int flareUpCount, @TimestampConverter()  DateTime? lastFlareUpDate,  bool isAkut,  List<int> scoreHistory)  $default,) {final _that = this;
switch (_that) {
case _RegionDetail():
return $default(_that.regionId,_that.nprsScore,_that.flareUpCount,_that.lastFlareUpDate,_that.isAkut,_that.scoreHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String regionId,  int nprsScore,  int flareUpCount, @TimestampConverter()  DateTime? lastFlareUpDate,  bool isAkut,  List<int> scoreHistory)?  $default,) {final _that = this;
switch (_that) {
case _RegionDetail() when $default != null:
return $default(_that.regionId,_that.nprsScore,_that.flareUpCount,_that.lastFlareUpDate,_that.isAkut,_that.scoreHistory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionDetail implements RegionDetail {
  const _RegionDetail({required this.regionId, this.nprsScore = 0, this.flareUpCount = 0, @TimestampConverter() this.lastFlareUpDate, this.isAkut = false, final  List<int> scoreHistory = const []}): _scoreHistory = scoreHistory;
  factory _RegionDetail.fromJson(Map<String, dynamic> json) => _$RegionDetailFromJson(json);

@override final  String regionId;
@override@JsonKey() final  int nprsScore;
@override@JsonKey() final  int flareUpCount;
@override@TimestampConverter() final  DateTime? lastFlareUpDate;
@override@JsonKey() final  bool isAkut;
 final  List<int> _scoreHistory;
@override@JsonKey() List<int> get scoreHistory {
  if (_scoreHistory is EqualUnmodifiableListView) return _scoreHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scoreHistory);
}


/// Create a copy of RegionDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionDetailCopyWith<_RegionDetail> get copyWith => __$RegionDetailCopyWithImpl<_RegionDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionDetail&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.nprsScore, nprsScore) || other.nprsScore == nprsScore)&&(identical(other.flareUpCount, flareUpCount) || other.flareUpCount == flareUpCount)&&(identical(other.lastFlareUpDate, lastFlareUpDate) || other.lastFlareUpDate == lastFlareUpDate)&&(identical(other.isAkut, isAkut) || other.isAkut == isAkut)&&const DeepCollectionEquality().equals(other._scoreHistory, _scoreHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,nprsScore,flareUpCount,lastFlareUpDate,isAkut,const DeepCollectionEquality().hash(_scoreHistory));

@override
String toString() {
  return 'RegionDetail(regionId: $regionId, nprsScore: $nprsScore, flareUpCount: $flareUpCount, lastFlareUpDate: $lastFlareUpDate, isAkut: $isAkut, scoreHistory: $scoreHistory)';
}


}

/// @nodoc
abstract mixin class _$RegionDetailCopyWith<$Res> implements $RegionDetailCopyWith<$Res> {
  factory _$RegionDetailCopyWith(_RegionDetail value, $Res Function(_RegionDetail) _then) = __$RegionDetailCopyWithImpl;
@override @useResult
$Res call({
 String regionId, int nprsScore, int flareUpCount,@TimestampConverter() DateTime? lastFlareUpDate, bool isAkut, List<int> scoreHistory
});




}
/// @nodoc
class __$RegionDetailCopyWithImpl<$Res>
    implements _$RegionDetailCopyWith<$Res> {
  __$RegionDetailCopyWithImpl(this._self, this._then);

  final _RegionDetail _self;
  final $Res Function(_RegionDetail) _then;

/// Create a copy of RegionDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionId = null,Object? nprsScore = null,Object? flareUpCount = null,Object? lastFlareUpDate = freezed,Object? isAkut = null,Object? scoreHistory = null,}) {
  return _then(_RegionDetail(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as String,nprsScore: null == nprsScore ? _self.nprsScore : nprsScore // ignore: cast_nullable_to_non_nullable
as int,flareUpCount: null == flareUpCount ? _self.flareUpCount : flareUpCount // ignore: cast_nullable_to_non_nullable
as int,lastFlareUpDate: freezed == lastFlareUpDate ? _self.lastFlareUpDate : lastFlareUpDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isAkut: null == isAkut ? _self.isAkut : isAkut // ignore: cast_nullable_to_non_nullable
as bool,scoreHistory: null == scoreHistory ? _self._scoreHistory : scoreHistory // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$UserModel {

 String get id; String get name; String get email; String? get sex; String? get profession; int? get dailySittingHours; bool get isBanned; BanReason? get banReason; String? get banNote; List<String> get flaggedRedFlagIds; RegistrationProgress get progress; List<RegionDetail> get painRegions; List<RegionDetail> get backlogRegions; List<String> get completedExerciseIds; Map<String, dynamic>? get currentProgram; int get currentStreak; int get totalWorkouts; Map<String, dynamic>? get metadata;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get lastActiveAt;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.profession, profession) || other.profession == profession)&&(identical(other.dailySittingHours, dailySittingHours) || other.dailySittingHours == dailySittingHours)&&(identical(other.isBanned, isBanned) || other.isBanned == isBanned)&&(identical(other.banReason, banReason) || other.banReason == banReason)&&(identical(other.banNote, banNote) || other.banNote == banNote)&&const DeepCollectionEquality().equals(other.flaggedRedFlagIds, flaggedRedFlagIds)&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other.painRegions, painRegions)&&const DeepCollectionEquality().equals(other.backlogRegions, backlogRegions)&&const DeepCollectionEquality().equals(other.completedExerciseIds, completedExerciseIds)&&const DeepCollectionEquality().equals(other.currentProgram, currentProgram)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.totalWorkouts, totalWorkouts) || other.totalWorkouts == totalWorkouts)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,email,sex,profession,dailySittingHours,isBanned,banReason,banNote,const DeepCollectionEquality().hash(flaggedRedFlagIds),progress,const DeepCollectionEquality().hash(painRegions),const DeepCollectionEquality().hash(backlogRegions),const DeepCollectionEquality().hash(completedExerciseIds),const DeepCollectionEquality().hash(currentProgram),currentStreak,totalWorkouts,const DeepCollectionEquality().hash(metadata),createdAt,lastActiveAt]);

@override
String toString() {
  return 'UserModel(id: $id, name: $name, email: $email, sex: $sex, profession: $profession, dailySittingHours: $dailySittingHours, isBanned: $isBanned, banReason: $banReason, banNote: $banNote, flaggedRedFlagIds: $flaggedRedFlagIds, progress: $progress, painRegions: $painRegions, backlogRegions: $backlogRegions, completedExerciseIds: $completedExerciseIds, currentProgram: $currentProgram, currentStreak: $currentStreak, totalWorkouts: $totalWorkouts, metadata: $metadata, createdAt: $createdAt, lastActiveAt: $lastActiveAt)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String email, String? sex, String? profession, int? dailySittingHours, bool isBanned, BanReason? banReason, String? banNote, List<String> flaggedRedFlagIds, RegistrationProgress progress, List<RegionDetail> painRegions, List<RegionDetail> backlogRegions, List<String> completedExerciseIds, Map<String, dynamic>? currentProgram, int currentStreak, int totalWorkouts, Map<String, dynamic>? metadata,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? lastActiveAt
});


$RegistrationProgressCopyWith<$Res> get progress;

}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? sex = freezed,Object? profession = freezed,Object? dailySittingHours = freezed,Object? isBanned = null,Object? banReason = freezed,Object? banNote = freezed,Object? flaggedRedFlagIds = null,Object? progress = null,Object? painRegions = null,Object? backlogRegions = null,Object? completedExerciseIds = null,Object? currentProgram = freezed,Object? currentStreak = null,Object? totalWorkouts = null,Object? metadata = freezed,Object? createdAt = freezed,Object? lastActiveAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,sex: freezed == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String?,profession: freezed == profession ? _self.profession : profession // ignore: cast_nullable_to_non_nullable
as String?,dailySittingHours: freezed == dailySittingHours ? _self.dailySittingHours : dailySittingHours // ignore: cast_nullable_to_non_nullable
as int?,isBanned: null == isBanned ? _self.isBanned : isBanned // ignore: cast_nullable_to_non_nullable
as bool,banReason: freezed == banReason ? _self.banReason : banReason // ignore: cast_nullable_to_non_nullable
as BanReason?,banNote: freezed == banNote ? _self.banNote : banNote // ignore: cast_nullable_to_non_nullable
as String?,flaggedRedFlagIds: null == flaggedRedFlagIds ? _self.flaggedRedFlagIds : flaggedRedFlagIds // ignore: cast_nullable_to_non_nullable
as List<String>,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as RegistrationProgress,painRegions: null == painRegions ? _self.painRegions : painRegions // ignore: cast_nullable_to_non_nullable
as List<RegionDetail>,backlogRegions: null == backlogRegions ? _self.backlogRegions : backlogRegions // ignore: cast_nullable_to_non_nullable
as List<RegionDetail>,completedExerciseIds: null == completedExerciseIds ? _self.completedExerciseIds : completedExerciseIds // ignore: cast_nullable_to_non_nullable
as List<String>,currentProgram: freezed == currentProgram ? _self.currentProgram : currentProgram // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,totalWorkouts: null == totalWorkouts ? _self.totalWorkouts : totalWorkouts // ignore: cast_nullable_to_non_nullable
as int,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActiveAt: freezed == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistrationProgressCopyWith<$Res> get progress {
  
  return $RegistrationProgressCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String? sex,  String? profession,  int? dailySittingHours,  bool isBanned,  BanReason? banReason,  String? banNote,  List<String> flaggedRedFlagIds,  RegistrationProgress progress,  List<RegionDetail> painRegions,  List<RegionDetail> backlogRegions,  List<String> completedExerciseIds,  Map<String, dynamic>? currentProgram,  int currentStreak,  int totalWorkouts,  Map<String, dynamic>? metadata, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? lastActiveAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.sex,_that.profession,_that.dailySittingHours,_that.isBanned,_that.banReason,_that.banNote,_that.flaggedRedFlagIds,_that.progress,_that.painRegions,_that.backlogRegions,_that.completedExerciseIds,_that.currentProgram,_that.currentStreak,_that.totalWorkouts,_that.metadata,_that.createdAt,_that.lastActiveAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String? sex,  String? profession,  int? dailySittingHours,  bool isBanned,  BanReason? banReason,  String? banNote,  List<String> flaggedRedFlagIds,  RegistrationProgress progress,  List<RegionDetail> painRegions,  List<RegionDetail> backlogRegions,  List<String> completedExerciseIds,  Map<String, dynamic>? currentProgram,  int currentStreak,  int totalWorkouts,  Map<String, dynamic>? metadata, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? lastActiveAt)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.name,_that.email,_that.sex,_that.profession,_that.dailySittingHours,_that.isBanned,_that.banReason,_that.banNote,_that.flaggedRedFlagIds,_that.progress,_that.painRegions,_that.backlogRegions,_that.completedExerciseIds,_that.currentProgram,_that.currentStreak,_that.totalWorkouts,_that.metadata,_that.createdAt,_that.lastActiveAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String email,  String? sex,  String? profession,  int? dailySittingHours,  bool isBanned,  BanReason? banReason,  String? banNote,  List<String> flaggedRedFlagIds,  RegistrationProgress progress,  List<RegionDetail> painRegions,  List<RegionDetail> backlogRegions,  List<String> completedExerciseIds,  Map<String, dynamic>? currentProgram,  int currentStreak,  int totalWorkouts,  Map<String, dynamic>? metadata, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? lastActiveAt)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.sex,_that.profession,_that.dailySittingHours,_that.isBanned,_that.banReason,_that.banNote,_that.flaggedRedFlagIds,_that.progress,_that.painRegions,_that.backlogRegions,_that.completedExerciseIds,_that.currentProgram,_that.currentStreak,_that.totalWorkouts,_that.metadata,_that.createdAt,_that.lastActiveAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel implements UserModel {
  const _UserModel({required this.id, required this.name, required this.email, this.sex, this.profession, this.dailySittingHours, this.isBanned = false, this.banReason, this.banNote, final  List<String> flaggedRedFlagIds = const [], this.progress = const RegistrationProgress(), final  List<RegionDetail> painRegions = const [], final  List<RegionDetail> backlogRegions = const [], final  List<String> completedExerciseIds = const [], final  Map<String, dynamic>? currentProgram, this.currentStreak = 0, this.totalWorkouts = 0, final  Map<String, dynamic>? metadata, @TimestampConverter() this.createdAt, @TimestampConverter() this.lastActiveAt}): _flaggedRedFlagIds = flaggedRedFlagIds,_painRegions = painRegions,_backlogRegions = backlogRegions,_completedExerciseIds = completedExerciseIds,_currentProgram = currentProgram,_metadata = metadata;
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String email;
@override final  String? sex;
@override final  String? profession;
@override final  int? dailySittingHours;
@override@JsonKey() final  bool isBanned;
@override final  BanReason? banReason;
@override final  String? banNote;
 final  List<String> _flaggedRedFlagIds;
@override@JsonKey() List<String> get flaggedRedFlagIds {
  if (_flaggedRedFlagIds is EqualUnmodifiableListView) return _flaggedRedFlagIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flaggedRedFlagIds);
}

@override@JsonKey() final  RegistrationProgress progress;
 final  List<RegionDetail> _painRegions;
@override@JsonKey() List<RegionDetail> get painRegions {
  if (_painRegions is EqualUnmodifiableListView) return _painRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_painRegions);
}

 final  List<RegionDetail> _backlogRegions;
@override@JsonKey() List<RegionDetail> get backlogRegions {
  if (_backlogRegions is EqualUnmodifiableListView) return _backlogRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_backlogRegions);
}

 final  List<String> _completedExerciseIds;
@override@JsonKey() List<String> get completedExerciseIds {
  if (_completedExerciseIds is EqualUnmodifiableListView) return _completedExerciseIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completedExerciseIds);
}

 final  Map<String, dynamic>? _currentProgram;
@override Map<String, dynamic>? get currentProgram {
  final value = _currentProgram;
  if (value == null) return null;
  if (_currentProgram is EqualUnmodifiableMapView) return _currentProgram;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey() final  int currentStreak;
@override@JsonKey() final  int totalWorkouts;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? lastActiveAt;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.profession, profession) || other.profession == profession)&&(identical(other.dailySittingHours, dailySittingHours) || other.dailySittingHours == dailySittingHours)&&(identical(other.isBanned, isBanned) || other.isBanned == isBanned)&&(identical(other.banReason, banReason) || other.banReason == banReason)&&(identical(other.banNote, banNote) || other.banNote == banNote)&&const DeepCollectionEquality().equals(other._flaggedRedFlagIds, _flaggedRedFlagIds)&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other._painRegions, _painRegions)&&const DeepCollectionEquality().equals(other._backlogRegions, _backlogRegions)&&const DeepCollectionEquality().equals(other._completedExerciseIds, _completedExerciseIds)&&const DeepCollectionEquality().equals(other._currentProgram, _currentProgram)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.totalWorkouts, totalWorkouts) || other.totalWorkouts == totalWorkouts)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,email,sex,profession,dailySittingHours,isBanned,banReason,banNote,const DeepCollectionEquality().hash(_flaggedRedFlagIds),progress,const DeepCollectionEquality().hash(_painRegions),const DeepCollectionEquality().hash(_backlogRegions),const DeepCollectionEquality().hash(_completedExerciseIds),const DeepCollectionEquality().hash(_currentProgram),currentStreak,totalWorkouts,const DeepCollectionEquality().hash(_metadata),createdAt,lastActiveAt]);

@override
String toString() {
  return 'UserModel(id: $id, name: $name, email: $email, sex: $sex, profession: $profession, dailySittingHours: $dailySittingHours, isBanned: $isBanned, banReason: $banReason, banNote: $banNote, flaggedRedFlagIds: $flaggedRedFlagIds, progress: $progress, painRegions: $painRegions, backlogRegions: $backlogRegions, completedExerciseIds: $completedExerciseIds, currentProgram: $currentProgram, currentStreak: $currentStreak, totalWorkouts: $totalWorkouts, metadata: $metadata, createdAt: $createdAt, lastActiveAt: $lastActiveAt)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String email, String? sex, String? profession, int? dailySittingHours, bool isBanned, BanReason? banReason, String? banNote, List<String> flaggedRedFlagIds, RegistrationProgress progress, List<RegionDetail> painRegions, List<RegionDetail> backlogRegions, List<String> completedExerciseIds, Map<String, dynamic>? currentProgram, int currentStreak, int totalWorkouts, Map<String, dynamic>? metadata,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? lastActiveAt
});


@override $RegistrationProgressCopyWith<$Res> get progress;

}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? sex = freezed,Object? profession = freezed,Object? dailySittingHours = freezed,Object? isBanned = null,Object? banReason = freezed,Object? banNote = freezed,Object? flaggedRedFlagIds = null,Object? progress = null,Object? painRegions = null,Object? backlogRegions = null,Object? completedExerciseIds = null,Object? currentProgram = freezed,Object? currentStreak = null,Object? totalWorkouts = null,Object? metadata = freezed,Object? createdAt = freezed,Object? lastActiveAt = freezed,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,sex: freezed == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String?,profession: freezed == profession ? _self.profession : profession // ignore: cast_nullable_to_non_nullable
as String?,dailySittingHours: freezed == dailySittingHours ? _self.dailySittingHours : dailySittingHours // ignore: cast_nullable_to_non_nullable
as int?,isBanned: null == isBanned ? _self.isBanned : isBanned // ignore: cast_nullable_to_non_nullable
as bool,banReason: freezed == banReason ? _self.banReason : banReason // ignore: cast_nullable_to_non_nullable
as BanReason?,banNote: freezed == banNote ? _self.banNote : banNote // ignore: cast_nullable_to_non_nullable
as String?,flaggedRedFlagIds: null == flaggedRedFlagIds ? _self._flaggedRedFlagIds : flaggedRedFlagIds // ignore: cast_nullable_to_non_nullable
as List<String>,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as RegistrationProgress,painRegions: null == painRegions ? _self._painRegions : painRegions // ignore: cast_nullable_to_non_nullable
as List<RegionDetail>,backlogRegions: null == backlogRegions ? _self._backlogRegions : backlogRegions // ignore: cast_nullable_to_non_nullable
as List<RegionDetail>,completedExerciseIds: null == completedExerciseIds ? _self._completedExerciseIds : completedExerciseIds // ignore: cast_nullable_to_non_nullable
as List<String>,currentProgram: freezed == currentProgram ? _self._currentProgram : currentProgram // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,totalWorkouts: null == totalWorkouts ? _self.totalWorkouts : totalWorkouts // ignore: cast_nullable_to_non_nullable
as int,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActiveAt: freezed == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistrationProgressCopyWith<$Res> get progress {
  
  return $RegistrationProgressCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}

// dart format on
