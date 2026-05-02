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
mixin _$MotivationModel {

 String get id;@JsonKey(name: 'bct_focus') String? get bctFocus; Map<String, String> get text; String get category;
/// Create a copy of MotivationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MotivationModelCopyWith<MotivationModel> get copyWith => _$MotivationModelCopyWithImpl<MotivationModel>(this as MotivationModel, _$identity);

  /// Serializes this MotivationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MotivationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.bctFocus, bctFocus) || other.bctFocus == bctFocus)&&const DeepCollectionEquality().equals(other.text, text)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bctFocus,const DeepCollectionEquality().hash(text),category);

@override
String toString() {
  return 'MotivationModel(id: $id, bctFocus: $bctFocus, text: $text, category: $category)';
}


}

/// @nodoc
abstract mixin class $MotivationModelCopyWith<$Res>  {
  factory $MotivationModelCopyWith(MotivationModel value, $Res Function(MotivationModel) _then) = _$MotivationModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'bct_focus') String? bctFocus, Map<String, String> text, String category
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bctFocus = freezed,Object? text = null,Object? category = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bctFocus: freezed == bctFocus ? _self.bctFocus : bctFocus // ignore: cast_nullable_to_non_nullable
as String?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as Map<String, String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'bct_focus')  String? bctFocus,  Map<String, String> text,  String category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MotivationModel() when $default != null:
return $default(_that.id,_that.bctFocus,_that.text,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'bct_focus')  String? bctFocus,  Map<String, String> text,  String category)  $default,) {final _that = this;
switch (_that) {
case _MotivationModel():
return $default(_that.id,_that.bctFocus,_that.text,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'bct_focus')  String? bctFocus,  Map<String, String> text,  String category)?  $default,) {final _that = this;
switch (_that) {
case _MotivationModel() when $default != null:
return $default(_that.id,_that.bctFocus,_that.text,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MotivationModel implements MotivationModel {
  const _MotivationModel({required this.id, @JsonKey(name: 'bct_focus') this.bctFocus, required final  Map<String, String> text, this.category = ''}): _text = text;
  factory _MotivationModel.fromJson(Map<String, dynamic> json) => _$MotivationModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'bct_focus') final  String? bctFocus;
 final  Map<String, String> _text;
@override Map<String, String> get text {
  if (_text is EqualUnmodifiableMapView) return _text;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_text);
}

@override@JsonKey() final  String category;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MotivationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.bctFocus, bctFocus) || other.bctFocus == bctFocus)&&const DeepCollectionEquality().equals(other._text, _text)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bctFocus,const DeepCollectionEquality().hash(_text),category);

@override
String toString() {
  return 'MotivationModel(id: $id, bctFocus: $bctFocus, text: $text, category: $category)';
}


}

/// @nodoc
abstract mixin class _$MotivationModelCopyWith<$Res> implements $MotivationModelCopyWith<$Res> {
  factory _$MotivationModelCopyWith(_MotivationModel value, $Res Function(_MotivationModel) _then) = __$MotivationModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'bct_focus') String? bctFocus, Map<String, String> text, String category
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bctFocus = freezed,Object? text = null,Object? category = null,}) {
  return _then(_MotivationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bctFocus: freezed == bctFocus ? _self.bctFocus : bctFocus // ignore: cast_nullable_to_non_nullable
as String?,text: null == text ? _self._text : text // ignore: cast_nullable_to_non_nullable
as Map<String, String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ErgoTipModel {

 String get id; String? get rationale; Map<String, String> get content;
/// Create a copy of ErgoTipModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErgoTipModelCopyWith<ErgoTipModel> get copyWith => _$ErgoTipModelCopyWithImpl<ErgoTipModel>(this as ErgoTipModel, _$identity);

  /// Serializes this ErgoTipModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErgoTipModel&&(identical(other.id, id) || other.id == id)&&(identical(other.rationale, rationale) || other.rationale == rationale)&&const DeepCollectionEquality().equals(other.content, content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rationale,const DeepCollectionEquality().hash(content));

@override
String toString() {
  return 'ErgoTipModel(id: $id, rationale: $rationale, content: $content)';
}


}

/// @nodoc
abstract mixin class $ErgoTipModelCopyWith<$Res>  {
  factory $ErgoTipModelCopyWith(ErgoTipModel value, $Res Function(ErgoTipModel) _then) = _$ErgoTipModelCopyWithImpl;
@useResult
$Res call({
 String id, String? rationale, Map<String, String> content
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rationale = freezed,Object? content = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rationale: freezed == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? rationale,  Map<String, String> content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErgoTipModel() when $default != null:
return $default(_that.id,_that.rationale,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? rationale,  Map<String, String> content)  $default,) {final _that = this;
switch (_that) {
case _ErgoTipModel():
return $default(_that.id,_that.rationale,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? rationale,  Map<String, String> content)?  $default,) {final _that = this;
switch (_that) {
case _ErgoTipModel() when $default != null:
return $default(_that.id,_that.rationale,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ErgoTipModel implements ErgoTipModel {
  const _ErgoTipModel({required this.id, this.rationale, required final  Map<String, String> content}): _content = content;
  factory _ErgoTipModel.fromJson(Map<String, dynamic> json) => _$ErgoTipModelFromJson(json);

@override final  String id;
@override final  String? rationale;
 final  Map<String, String> _content;
@override Map<String, String> get content {
  if (_content is EqualUnmodifiableMapView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_content);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErgoTipModel&&(identical(other.id, id) || other.id == id)&&(identical(other.rationale, rationale) || other.rationale == rationale)&&const DeepCollectionEquality().equals(other._content, _content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rationale,const DeepCollectionEquality().hash(_content));

@override
String toString() {
  return 'ErgoTipModel(id: $id, rationale: $rationale, content: $content)';
}


}

/// @nodoc
abstract mixin class _$ErgoTipModelCopyWith<$Res> implements $ErgoTipModelCopyWith<$Res> {
  factory _$ErgoTipModelCopyWith(_ErgoTipModel value, $Res Function(_ErgoTipModel) _then) = __$ErgoTipModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? rationale, Map<String, String> content
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rationale = freezed,Object? content = null,}) {
  return _then(_ErgoTipModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rationale: freezed == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}


/// @nodoc
mixin _$BlogPostModel {

 String get id; String get category;@JsonKey(name: 'image_url') String get imageUrl; Map<String, String> get title; Map<String, String> get summary; Map<String, String> get content; List<String> get tags;
/// Create a copy of BlogPostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlogPostModelCopyWith<BlogPostModel> get copyWith => _$BlogPostModelCopyWithImpl<BlogPostModel>(this as BlogPostModel, _$identity);

  /// Serializes this BlogPostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlogPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.title, title)&&const DeepCollectionEquality().equals(other.summary, summary)&&const DeepCollectionEquality().equals(other.content, content)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,imageUrl,const DeepCollectionEquality().hash(title),const DeepCollectionEquality().hash(summary),const DeepCollectionEquality().hash(content),const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'BlogPostModel(id: $id, category: $category, imageUrl: $imageUrl, title: $title, summary: $summary, content: $content, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $BlogPostModelCopyWith<$Res>  {
  factory $BlogPostModelCopyWith(BlogPostModel value, $Res Function(BlogPostModel) _then) = _$BlogPostModelCopyWithImpl;
@useResult
$Res call({
 String id, String category,@JsonKey(name: 'image_url') String imageUrl, Map<String, String> title, Map<String, String> summary, Map<String, String> content, List<String> tags
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? imageUrl = null,Object? title = null,Object? summary = null,Object? content = null,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Map<String, String>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as Map<String, String>,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Map<String, String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String category, @JsonKey(name: 'image_url')  String imageUrl,  Map<String, String> title,  Map<String, String> summary,  Map<String, String> content,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlogPostModel() when $default != null:
return $default(_that.id,_that.category,_that.imageUrl,_that.title,_that.summary,_that.content,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String category, @JsonKey(name: 'image_url')  String imageUrl,  Map<String, String> title,  Map<String, String> summary,  Map<String, String> content,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _BlogPostModel():
return $default(_that.id,_that.category,_that.imageUrl,_that.title,_that.summary,_that.content,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String category, @JsonKey(name: 'image_url')  String imageUrl,  Map<String, String> title,  Map<String, String> summary,  Map<String, String> content,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _BlogPostModel() when $default != null:
return $default(_that.id,_that.category,_that.imageUrl,_that.title,_that.summary,_that.content,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlogPostModel implements BlogPostModel {
  const _BlogPostModel({required this.id, required this.category, @JsonKey(name: 'image_url') required this.imageUrl, required final  Map<String, String> title, required final  Map<String, String> summary, required final  Map<String, String> content, final  List<String> tags = const []}): _title = title,_summary = summary,_content = content,_tags = tags;
  factory _BlogPostModel.fromJson(Map<String, dynamic> json) => _$BlogPostModelFromJson(json);

@override final  String id;
@override final  String category;
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

 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlogPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._title, _title)&&const DeepCollectionEquality().equals(other._summary, _summary)&&const DeepCollectionEquality().equals(other._content, _content)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,imageUrl,const DeepCollectionEquality().hash(_title),const DeepCollectionEquality().hash(_summary),const DeepCollectionEquality().hash(_content),const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'BlogPostModel(id: $id, category: $category, imageUrl: $imageUrl, title: $title, summary: $summary, content: $content, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$BlogPostModelCopyWith<$Res> implements $BlogPostModelCopyWith<$Res> {
  factory _$BlogPostModelCopyWith(_BlogPostModel value, $Res Function(_BlogPostModel) _then) = __$BlogPostModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String category,@JsonKey(name: 'image_url') String imageUrl, Map<String, String> title, Map<String, String> summary, Map<String, String> content, List<String> tags
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? imageUrl = null,Object? title = null,Object? summary = null,Object? content = null,Object? tags = null,}) {
  return _then(_BlogPostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self._title : title // ignore: cast_nullable_to_non_nullable
as Map<String, String>,summary: null == summary ? _self._summary : summary // ignore: cast_nullable_to_non_nullable
as Map<String, String>,content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as Map<String, String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
