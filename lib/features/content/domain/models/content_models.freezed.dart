// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BlogCitation {

 String get title; String get url;
/// Create a copy of BlogCitation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlogCitationCopyWith<BlogCitation> get copyWith => _$BlogCitationCopyWithImpl<BlogCitation>(this as BlogCitation, _$identity);

  /// Serializes this BlogCitation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlogCitation&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,url);

@override
String toString() {
  return 'BlogCitation(title: $title, url: $url)';
}


}

/// @nodoc
abstract mixin class $BlogCitationCopyWith<$Res>  {
  factory $BlogCitationCopyWith(BlogCitation value, $Res Function(BlogCitation) _then) = _$BlogCitationCopyWithImpl;
@useResult
$Res call({
 String title, String url
});




}
/// @nodoc
class _$BlogCitationCopyWithImpl<$Res>
    implements $BlogCitationCopyWith<$Res> {
  _$BlogCitationCopyWithImpl(this._self, this._then);

  final BlogCitation _self;
  final $Res Function(BlogCitation) _then;

/// Create a copy of BlogCitation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? url = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BlogCitation].
extension BlogCitationPatterns on BlogCitation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlogCitation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlogCitation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlogCitation value)  $default,){
final _that = this;
switch (_that) {
case _BlogCitation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlogCitation value)?  $default,){
final _that = this;
switch (_that) {
case _BlogCitation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlogCitation() when $default != null:
return $default(_that.title,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String url)  $default,) {final _that = this;
switch (_that) {
case _BlogCitation():
return $default(_that.title,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String url)?  $default,) {final _that = this;
switch (_that) {
case _BlogCitation() when $default != null:
return $default(_that.title,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlogCitation implements BlogCitation {
  const _BlogCitation({required this.title, required this.url});
  factory _BlogCitation.fromJson(Map<String, dynamic> json) => _$BlogCitationFromJson(json);

@override final  String title;
@override final  String url;

/// Create a copy of BlogCitation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlogCitationCopyWith<_BlogCitation> get copyWith => __$BlogCitationCopyWithImpl<_BlogCitation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlogCitationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlogCitation&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,url);

@override
String toString() {
  return 'BlogCitation(title: $title, url: $url)';
}


}

/// @nodoc
abstract mixin class _$BlogCitationCopyWith<$Res> implements $BlogCitationCopyWith<$Res> {
  factory _$BlogCitationCopyWith(_BlogCitation value, $Res Function(_BlogCitation) _then) = __$BlogCitationCopyWithImpl;
@override @useResult
$Res call({
 String title, String url
});




}
/// @nodoc
class __$BlogCitationCopyWithImpl<$Res>
    implements _$BlogCitationCopyWith<$Res> {
  __$BlogCitationCopyWithImpl(this._self, this._then);

  final _BlogCitation _self;
  final $Res Function(_BlogCitation) _then;

/// Create a copy of BlogCitation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? url = null,}) {
  return _then(_BlogCitation(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MotivationModel {

 String get id;@JsonKey(name: 'bct_focus') String? get bctFocus;@JsonKey(name: 'bct_focus_tr') String? get bctFocusTr; Map<String, String> get text; String get category;// Populated during parsing (e.g., 'screen_greetings')
 String? get citations;
/// Create a copy of MotivationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MotivationModelCopyWith<MotivationModel> get copyWith => _$MotivationModelCopyWithImpl<MotivationModel>(this as MotivationModel, _$identity);

  /// Serializes this MotivationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MotivationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.bctFocus, bctFocus) || other.bctFocus == bctFocus)&&(identical(other.bctFocusTr, bctFocusTr) || other.bctFocusTr == bctFocusTr)&&const DeepCollectionEquality().equals(other.text, text)&&(identical(other.category, category) || other.category == category)&&(identical(other.citations, citations) || other.citations == citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bctFocus,bctFocusTr,const DeepCollectionEquality().hash(text),category,citations);

@override
String toString() {
  return 'MotivationModel(id: $id, bctFocus: $bctFocus, bctFocusTr: $bctFocusTr, text: $text, category: $category, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $MotivationModelCopyWith<$Res>  {
  factory $MotivationModelCopyWith(MotivationModel value, $Res Function(MotivationModel) _then) = _$MotivationModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'bct_focus') String? bctFocus,@JsonKey(name: 'bct_focus_tr') String? bctFocusTr, Map<String, String> text, String category, String? citations
});




}
/// @nodoc
class _$MotivationModelCopyWithImpl<$Res>
    implements $MotivationModelCopyWith<$Res> {
  _$MotivationModelCopyWithImpl(this._self, this._then);

  final MotivationModel _self;
  final $Res Function(MotivationModel) _then;

/// Create a copy of MotivationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bctFocus = freezed,Object? bctFocusTr = freezed,Object? text = null,Object? category = null,Object? citations = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bctFocus: freezed == bctFocus ? _self.bctFocus : bctFocus // ignore: cast_nullable_to_non_nullable
as String?,bctFocusTr: freezed == bctFocusTr ? _self.bctFocusTr : bctFocusTr // ignore: cast_nullable_to_non_nullable
as String?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as Map<String, String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,citations: freezed == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MotivationModel].
extension MotivationModelPatterns on MotivationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MotivationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MotivationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MotivationModel value)  $default,){
final _that = this;
switch (_that) {
case _MotivationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MotivationModel value)?  $default,){
final _that = this;
switch (_that) {
case _MotivationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'bct_focus')  String? bctFocus, @JsonKey(name: 'bct_focus_tr')  String? bctFocusTr,  Map<String, String> text,  String category,  String? citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MotivationModel() when $default != null:
return $default(_that.id,_that.bctFocus,_that.bctFocusTr,_that.text,_that.category,_that.citations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'bct_focus')  String? bctFocus, @JsonKey(name: 'bct_focus_tr')  String? bctFocusTr,  Map<String, String> text,  String category,  String? citations)  $default,) {final _that = this;
switch (_that) {
case _MotivationModel():
return $default(_that.id,_that.bctFocus,_that.bctFocusTr,_that.text,_that.category,_that.citations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'bct_focus')  String? bctFocus, @JsonKey(name: 'bct_focus_tr')  String? bctFocusTr,  Map<String, String> text,  String category,  String? citations)?  $default,) {final _that = this;
switch (_that) {
case _MotivationModel() when $default != null:
return $default(_that.id,_that.bctFocus,_that.bctFocusTr,_that.text,_that.category,_that.citations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MotivationModel implements MotivationModel {
  const _MotivationModel({required this.id, @JsonKey(name: 'bct_focus') this.bctFocus, @JsonKey(name: 'bct_focus_tr') this.bctFocusTr, required final  Map<String, String> text, this.category = '', this.citations}): _text = text;
  factory _MotivationModel.fromJson(Map<String, dynamic> json) => _$MotivationModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'bct_focus') final  String? bctFocus;
@override@JsonKey(name: 'bct_focus_tr') final  String? bctFocusTr;
 final  Map<String, String> _text;
@override Map<String, String> get text {
  if (_text is EqualUnmodifiableMapView) return _text;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_text);
}

@override@JsonKey() final  String category;
// Populated during parsing (e.g., 'screen_greetings')
@override final  String? citations;

/// Create a copy of MotivationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MotivationModelCopyWith<_MotivationModel> get copyWith => __$MotivationModelCopyWithImpl<_MotivationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MotivationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MotivationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.bctFocus, bctFocus) || other.bctFocus == bctFocus)&&(identical(other.bctFocusTr, bctFocusTr) || other.bctFocusTr == bctFocusTr)&&const DeepCollectionEquality().equals(other._text, _text)&&(identical(other.category, category) || other.category == category)&&(identical(other.citations, citations) || other.citations == citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bctFocus,bctFocusTr,const DeepCollectionEquality().hash(_text),category,citations);

@override
String toString() {
  return 'MotivationModel(id: $id, bctFocus: $bctFocus, bctFocusTr: $bctFocusTr, text: $text, category: $category, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$MotivationModelCopyWith<$Res> implements $MotivationModelCopyWith<$Res> {
  factory _$MotivationModelCopyWith(_MotivationModel value, $Res Function(_MotivationModel) _then) = __$MotivationModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'bct_focus') String? bctFocus,@JsonKey(name: 'bct_focus_tr') String? bctFocusTr, Map<String, String> text, String category, String? citations
});




}
/// @nodoc
class __$MotivationModelCopyWithImpl<$Res>
    implements _$MotivationModelCopyWith<$Res> {
  __$MotivationModelCopyWithImpl(this._self, this._then);

  final _MotivationModel _self;
  final $Res Function(_MotivationModel) _then;

/// Create a copy of MotivationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bctFocus = freezed,Object? bctFocusTr = freezed,Object? text = null,Object? category = null,Object? citations = freezed,}) {
  return _then(_MotivationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bctFocus: freezed == bctFocus ? _self.bctFocus : bctFocus // ignore: cast_nullable_to_non_nullable
as String?,bctFocusTr: freezed == bctFocusTr ? _self.bctFocusTr : bctFocusTr // ignore: cast_nullable_to_non_nullable
as String?,text: null == text ? _self._text : text // ignore: cast_nullable_to_non_nullable
as Map<String, String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,citations: freezed == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ErgoTipModel {

 String get id; String? get rationale;@JsonKey(name: 'rationale_tr') String? get rationaleTr; Map<String, String>? get content;// Used in regional_tips
 Map<String, String>? get text;// Used in ergonomic_micro_interventions
 String? get citations;
/// Create a copy of ErgoTipModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErgoTipModelCopyWith<ErgoTipModel> get copyWith => _$ErgoTipModelCopyWithImpl<ErgoTipModel>(this as ErgoTipModel, _$identity);

  /// Serializes this ErgoTipModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErgoTipModel&&(identical(other.id, id) || other.id == id)&&(identical(other.rationale, rationale) || other.rationale == rationale)&&(identical(other.rationaleTr, rationaleTr) || other.rationaleTr == rationaleTr)&&const DeepCollectionEquality().equals(other.content, content)&&const DeepCollectionEquality().equals(other.text, text)&&(identical(other.citations, citations) || other.citations == citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rationale,rationaleTr,const DeepCollectionEquality().hash(content),const DeepCollectionEquality().hash(text),citations);

@override
String toString() {
  return 'ErgoTipModel(id: $id, rationale: $rationale, rationaleTr: $rationaleTr, content: $content, text: $text, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $ErgoTipModelCopyWith<$Res>  {
  factory $ErgoTipModelCopyWith(ErgoTipModel value, $Res Function(ErgoTipModel) _then) = _$ErgoTipModelCopyWithImpl;
@useResult
$Res call({
 String id, String? rationale,@JsonKey(name: 'rationale_tr') String? rationaleTr, Map<String, String>? content, Map<String, String>? text, String? citations
});




}
/// @nodoc
class _$ErgoTipModelCopyWithImpl<$Res>
    implements $ErgoTipModelCopyWith<$Res> {
  _$ErgoTipModelCopyWithImpl(this._self, this._then);

  final ErgoTipModel _self;
  final $Res Function(ErgoTipModel) _then;

/// Create a copy of ErgoTipModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rationale = freezed,Object? rationaleTr = freezed,Object? content = freezed,Object? text = freezed,Object? citations = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rationale: freezed == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String?,rationaleTr: freezed == rationaleTr ? _self.rationaleTr : rationaleTr // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,citations: freezed == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ErgoTipModel].
extension ErgoTipModelPatterns on ErgoTipModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ErgoTipModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ErgoTipModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ErgoTipModel value)  $default,){
final _that = this;
switch (_that) {
case _ErgoTipModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ErgoTipModel value)?  $default,){
final _that = this;
switch (_that) {
case _ErgoTipModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? rationale, @JsonKey(name: 'rationale_tr')  String? rationaleTr,  Map<String, String>? content,  Map<String, String>? text,  String? citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErgoTipModel() when $default != null:
return $default(_that.id,_that.rationale,_that.rationaleTr,_that.content,_that.text,_that.citations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? rationale, @JsonKey(name: 'rationale_tr')  String? rationaleTr,  Map<String, String>? content,  Map<String, String>? text,  String? citations)  $default,) {final _that = this;
switch (_that) {
case _ErgoTipModel():
return $default(_that.id,_that.rationale,_that.rationaleTr,_that.content,_that.text,_that.citations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? rationale, @JsonKey(name: 'rationale_tr')  String? rationaleTr,  Map<String, String>? content,  Map<String, String>? text,  String? citations)?  $default,) {final _that = this;
switch (_that) {
case _ErgoTipModel() when $default != null:
return $default(_that.id,_that.rationale,_that.rationaleTr,_that.content,_that.text,_that.citations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ErgoTipModel implements ErgoTipModel {
  const _ErgoTipModel({required this.id, this.rationale, @JsonKey(name: 'rationale_tr') this.rationaleTr, final  Map<String, String>? content, final  Map<String, String>? text, this.citations}): _content = content,_text = text;
  factory _ErgoTipModel.fromJson(Map<String, dynamic> json) => _$ErgoTipModelFromJson(json);

@override final  String id;
@override final  String? rationale;
@override@JsonKey(name: 'rationale_tr') final  String? rationaleTr;
 final  Map<String, String>? _content;
@override Map<String, String>? get content {
  final value = _content;
  if (value == null) return null;
  if (_content is EqualUnmodifiableMapView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Used in regional_tips
 final  Map<String, String>? _text;
// Used in regional_tips
@override Map<String, String>? get text {
  final value = _text;
  if (value == null) return null;
  if (_text is EqualUnmodifiableMapView) return _text;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Used in ergonomic_micro_interventions
@override final  String? citations;

/// Create a copy of ErgoTipModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErgoTipModelCopyWith<_ErgoTipModel> get copyWith => __$ErgoTipModelCopyWithImpl<_ErgoTipModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErgoTipModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErgoTipModel&&(identical(other.id, id) || other.id == id)&&(identical(other.rationale, rationale) || other.rationale == rationale)&&(identical(other.rationaleTr, rationaleTr) || other.rationaleTr == rationaleTr)&&const DeepCollectionEquality().equals(other._content, _content)&&const DeepCollectionEquality().equals(other._text, _text)&&(identical(other.citations, citations) || other.citations == citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rationale,rationaleTr,const DeepCollectionEquality().hash(_content),const DeepCollectionEquality().hash(_text),citations);

@override
String toString() {
  return 'ErgoTipModel(id: $id, rationale: $rationale, rationaleTr: $rationaleTr, content: $content, text: $text, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$ErgoTipModelCopyWith<$Res> implements $ErgoTipModelCopyWith<$Res> {
  factory _$ErgoTipModelCopyWith(_ErgoTipModel value, $Res Function(_ErgoTipModel) _then) = __$ErgoTipModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? rationale,@JsonKey(name: 'rationale_tr') String? rationaleTr, Map<String, String>? content, Map<String, String>? text, String? citations
});




}
/// @nodoc
class __$ErgoTipModelCopyWithImpl<$Res>
    implements _$ErgoTipModelCopyWith<$Res> {
  __$ErgoTipModelCopyWithImpl(this._self, this._then);

  final _ErgoTipModel _self;
  final $Res Function(_ErgoTipModel) _then;

/// Create a copy of ErgoTipModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rationale = freezed,Object? rationaleTr = freezed,Object? content = freezed,Object? text = freezed,Object? citations = freezed,}) {
  return _then(_ErgoTipModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rationale: freezed == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String?,rationaleTr: freezed == rationaleTr ? _self.rationaleTr : rationaleTr // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,text: freezed == text ? _self._text : text // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,citations: freezed == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BlogPostModel {

 String get id; Map<String, String> get category;@JsonKey(name: 'image_url') String get imageUrl; Map<String, String> get title; Map<String, String> get summary; Map<String, String> get content; List<BlogCitation>? get citations;
/// Create a copy of BlogPostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlogPostModelCopyWith<BlogPostModel> get copyWith => _$BlogPostModelCopyWithImpl<BlogPostModel>(this as BlogPostModel, _$identity);

  /// Serializes this BlogPostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlogPostModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.category, category)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.title, title)&&const DeepCollectionEquality().equals(other.summary, summary)&&const DeepCollectionEquality().equals(other.content, content)&&const DeepCollectionEquality().equals(other.citations, citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(category),imageUrl,const DeepCollectionEquality().hash(title),const DeepCollectionEquality().hash(summary),const DeepCollectionEquality().hash(content),const DeepCollectionEquality().hash(citations));

@override
String toString() {
  return 'BlogPostModel(id: $id, category: $category, imageUrl: $imageUrl, title: $title, summary: $summary, content: $content, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $BlogPostModelCopyWith<$Res>  {
  factory $BlogPostModelCopyWith(BlogPostModel value, $Res Function(BlogPostModel) _then) = _$BlogPostModelCopyWithImpl;
@useResult
$Res call({
 String id, Map<String, String> category,@JsonKey(name: 'image_url') String imageUrl, Map<String, String> title, Map<String, String> summary, Map<String, String> content, List<BlogCitation>? citations
});




}
/// @nodoc
class _$BlogPostModelCopyWithImpl<$Res>
    implements $BlogPostModelCopyWith<$Res> {
  _$BlogPostModelCopyWithImpl(this._self, this._then);

  final BlogPostModel _self;
  final $Res Function(BlogPostModel) _then;

/// Create a copy of BlogPostModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? imageUrl = null,Object? title = null,Object? summary = null,Object? content = null,Object? citations = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Map<String, String>,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Map<String, String>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as Map<String, String>,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Map<String, String>,citations: freezed == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<BlogCitation>?,
  ));
}

}


/// Adds pattern-matching-related methods to [BlogPostModel].
extension BlogPostModelPatterns on BlogPostModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlogPostModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlogPostModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlogPostModel value)  $default,){
final _that = this;
switch (_that) {
case _BlogPostModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlogPostModel value)?  $default,){
final _that = this;
switch (_that) {
case _BlogPostModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Map<String, String> category, @JsonKey(name: 'image_url')  String imageUrl,  Map<String, String> title,  Map<String, String> summary,  Map<String, String> content,  List<BlogCitation>? citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlogPostModel() when $default != null:
return $default(_that.id,_that.category,_that.imageUrl,_that.title,_that.summary,_that.content,_that.citations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Map<String, String> category, @JsonKey(name: 'image_url')  String imageUrl,  Map<String, String> title,  Map<String, String> summary,  Map<String, String> content,  List<BlogCitation>? citations)  $default,) {final _that = this;
switch (_that) {
case _BlogPostModel():
return $default(_that.id,_that.category,_that.imageUrl,_that.title,_that.summary,_that.content,_that.citations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Map<String, String> category, @JsonKey(name: 'image_url')  String imageUrl,  Map<String, String> title,  Map<String, String> summary,  Map<String, String> content,  List<BlogCitation>? citations)?  $default,) {final _that = this;
switch (_that) {
case _BlogPostModel() when $default != null:
return $default(_that.id,_that.category,_that.imageUrl,_that.title,_that.summary,_that.content,_that.citations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlogPostModel implements BlogPostModel {
  const _BlogPostModel({required this.id, required final  Map<String, String> category, @JsonKey(name: 'image_url') required this.imageUrl, required final  Map<String, String> title, required final  Map<String, String> summary, required final  Map<String, String> content, final  List<BlogCitation>? citations}): _category = category,_title = title,_summary = summary,_content = content,_citations = citations;
  factory _BlogPostModel.fromJson(Map<String, dynamic> json) => _$BlogPostModelFromJson(json);

@override final  String id;
 final  Map<String, String> _category;
@override Map<String, String> get category {
  if (_category is EqualUnmodifiableMapView) return _category;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_category);
}

@override@JsonKey(name: 'image_url') final  String imageUrl;
 final  Map<String, String> _title;
@override Map<String, String> get title {
  if (_title is EqualUnmodifiableMapView) return _title;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_title);
}

 final  Map<String, String> _summary;
@override Map<String, String> get summary {
  if (_summary is EqualUnmodifiableMapView) return _summary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_summary);
}

 final  Map<String, String> _content;
@override Map<String, String> get content {
  if (_content is EqualUnmodifiableMapView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_content);
}

 final  List<BlogCitation>? _citations;
@override List<BlogCitation>? get citations {
  final value = _citations;
  if (value == null) return null;
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of BlogPostModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlogPostModelCopyWith<_BlogPostModel> get copyWith => __$BlogPostModelCopyWithImpl<_BlogPostModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlogPostModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlogPostModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._category, _category)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._title, _title)&&const DeepCollectionEquality().equals(other._summary, _summary)&&const DeepCollectionEquality().equals(other._content, _content)&&const DeepCollectionEquality().equals(other._citations, _citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_category),imageUrl,const DeepCollectionEquality().hash(_title),const DeepCollectionEquality().hash(_summary),const DeepCollectionEquality().hash(_content),const DeepCollectionEquality().hash(_citations));

@override
String toString() {
  return 'BlogPostModel(id: $id, category: $category, imageUrl: $imageUrl, title: $title, summary: $summary, content: $content, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$BlogPostModelCopyWith<$Res> implements $BlogPostModelCopyWith<$Res> {
  factory _$BlogPostModelCopyWith(_BlogPostModel value, $Res Function(_BlogPostModel) _then) = __$BlogPostModelCopyWithImpl;
@override @useResult
$Res call({
 String id, Map<String, String> category,@JsonKey(name: 'image_url') String imageUrl, Map<String, String> title, Map<String, String> summary, Map<String, String> content, List<BlogCitation>? citations
});




}
/// @nodoc
class __$BlogPostModelCopyWithImpl<$Res>
    implements _$BlogPostModelCopyWith<$Res> {
  __$BlogPostModelCopyWithImpl(this._self, this._then);

  final _BlogPostModel _self;
  final $Res Function(_BlogPostModel) _then;

/// Create a copy of BlogPostModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? imageUrl = null,Object? title = null,Object? summary = null,Object? content = null,Object? citations = freezed,}) {
  return _then(_BlogPostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self._category : category // ignore: cast_nullable_to_non_nullable
as Map<String, String>,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self._title : title // ignore: cast_nullable_to_non_nullable
as Map<String, String>,summary: null == summary ? _self._summary : summary // ignore: cast_nullable_to_non_nullable
as Map<String, String>,content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as Map<String, String>,citations: freezed == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<BlogCitation>?,
  ));
}


}

// dart format on
