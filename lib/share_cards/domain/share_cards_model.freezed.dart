// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_cards_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShareCards {

 String? get id; String? get title; DateTime? get expectedReturnDate; DateTime? get returnedAt; ShareCardsStatus? get status; String? get notes; String get lender; String get applicant;@JsonKey(fromJson: _lendingCardsFromJson, toJson: _lendingCardsToJson) List<MtgCard> get lendingCards; DateTime? get lendingDate;
/// Create a copy of ShareCards
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShareCardsCopyWith<ShareCards> get copyWith => _$ShareCardsCopyWithImpl<ShareCards>(this as ShareCards, _$identity);

  /// Serializes this ShareCards to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShareCards&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.expectedReturnDate, expectedReturnDate) || other.expectedReturnDate == expectedReturnDate)&&(identical(other.returnedAt, returnedAt) || other.returnedAt == returnedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.lender, lender) || other.lender == lender)&&(identical(other.applicant, applicant) || other.applicant == applicant)&&const DeepCollectionEquality().equals(other.lendingCards, lendingCards)&&(identical(other.lendingDate, lendingDate) || other.lendingDate == lendingDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,expectedReturnDate,returnedAt,status,notes,lender,applicant,const DeepCollectionEquality().hash(lendingCards),lendingDate);

@override
String toString() {
  return 'ShareCards(id: $id, title: $title, expectedReturnDate: $expectedReturnDate, returnedAt: $returnedAt, status: $status, notes: $notes, lender: $lender, applicant: $applicant, lendingCards: $lendingCards, lendingDate: $lendingDate)';
}


}

/// @nodoc
abstract mixin class $ShareCardsCopyWith<$Res>  {
  factory $ShareCardsCopyWith(ShareCards value, $Res Function(ShareCards) _then) = _$ShareCardsCopyWithImpl;
@useResult
$Res call({
 String? id, String? title, DateTime? expectedReturnDate, DateTime? returnedAt, ShareCardsStatus? status, String? notes, String lender, String applicant,@JsonKey(fromJson: _lendingCardsFromJson, toJson: _lendingCardsToJson) List<MtgCard> lendingCards, DateTime? lendingDate
});




}
/// @nodoc
class _$ShareCardsCopyWithImpl<$Res>
    implements $ShareCardsCopyWith<$Res> {
  _$ShareCardsCopyWithImpl(this._self, this._then);

  final ShareCards _self;
  final $Res Function(ShareCards) _then;

/// Create a copy of ShareCards
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? expectedReturnDate = freezed,Object? returnedAt = freezed,Object? status = freezed,Object? notes = freezed,Object? lender = null,Object? applicant = null,Object? lendingCards = null,Object? lendingDate = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,expectedReturnDate: freezed == expectedReturnDate ? _self.expectedReturnDate : expectedReturnDate // ignore: cast_nullable_to_non_nullable
as DateTime?,returnedAt: freezed == returnedAt ? _self.returnedAt : returnedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ShareCardsStatus?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,lender: null == lender ? _self.lender : lender // ignore: cast_nullable_to_non_nullable
as String,applicant: null == applicant ? _self.applicant : applicant // ignore: cast_nullable_to_non_nullable
as String,lendingCards: null == lendingCards ? _self.lendingCards : lendingCards // ignore: cast_nullable_to_non_nullable
as List<MtgCard>,lendingDate: freezed == lendingDate ? _self.lendingDate : lendingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShareCards].
extension ShareCardsPatterns on ShareCards {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShareCards value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShareCards() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShareCards value)  $default,){
final _that = this;
switch (_that) {
case _ShareCards():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShareCards value)?  $default,){
final _that = this;
switch (_that) {
case _ShareCards() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? title,  DateTime? expectedReturnDate,  DateTime? returnedAt,  ShareCardsStatus? status,  String? notes,  String lender,  String applicant, @JsonKey(fromJson: _lendingCardsFromJson, toJson: _lendingCardsToJson)  List<MtgCard> lendingCards,  DateTime? lendingDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShareCards() when $default != null:
return $default(_that.id,_that.title,_that.expectedReturnDate,_that.returnedAt,_that.status,_that.notes,_that.lender,_that.applicant,_that.lendingCards,_that.lendingDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? title,  DateTime? expectedReturnDate,  DateTime? returnedAt,  ShareCardsStatus? status,  String? notes,  String lender,  String applicant, @JsonKey(fromJson: _lendingCardsFromJson, toJson: _lendingCardsToJson)  List<MtgCard> lendingCards,  DateTime? lendingDate)  $default,) {final _that = this;
switch (_that) {
case _ShareCards():
return $default(_that.id,_that.title,_that.expectedReturnDate,_that.returnedAt,_that.status,_that.notes,_that.lender,_that.applicant,_that.lendingCards,_that.lendingDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? title,  DateTime? expectedReturnDate,  DateTime? returnedAt,  ShareCardsStatus? status,  String? notes,  String lender,  String applicant, @JsonKey(fromJson: _lendingCardsFromJson, toJson: _lendingCardsToJson)  List<MtgCard> lendingCards,  DateTime? lendingDate)?  $default,) {final _that = this;
switch (_that) {
case _ShareCards() when $default != null:
return $default(_that.id,_that.title,_that.expectedReturnDate,_that.returnedAt,_that.status,_that.notes,_that.lender,_that.applicant,_that.lendingCards,_that.lendingDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShareCards extends ShareCards {
  const _ShareCards({this.id, this.title, this.expectedReturnDate, this.returnedAt, this.status, this.notes, required this.lender, required this.applicant, @JsonKey(fromJson: _lendingCardsFromJson, toJson: _lendingCardsToJson) required final  List<MtgCard> lendingCards, this.lendingDate}): _lendingCards = lendingCards,super._();
  factory _ShareCards.fromJson(Map<String, dynamic> json) => _$ShareCardsFromJson(json);

@override final  String? id;
@override final  String? title;
@override final  DateTime? expectedReturnDate;
@override final  DateTime? returnedAt;
@override final  ShareCardsStatus? status;
@override final  String? notes;
@override final  String lender;
@override final  String applicant;
 final  List<MtgCard> _lendingCards;
@override@JsonKey(fromJson: _lendingCardsFromJson, toJson: _lendingCardsToJson) List<MtgCard> get lendingCards {
  if (_lendingCards is EqualUnmodifiableListView) return _lendingCards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lendingCards);
}

@override final  DateTime? lendingDate;

/// Create a copy of ShareCards
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShareCardsCopyWith<_ShareCards> get copyWith => __$ShareCardsCopyWithImpl<_ShareCards>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShareCardsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShareCards&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.expectedReturnDate, expectedReturnDate) || other.expectedReturnDate == expectedReturnDate)&&(identical(other.returnedAt, returnedAt) || other.returnedAt == returnedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.lender, lender) || other.lender == lender)&&(identical(other.applicant, applicant) || other.applicant == applicant)&&const DeepCollectionEquality().equals(other._lendingCards, _lendingCards)&&(identical(other.lendingDate, lendingDate) || other.lendingDate == lendingDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,expectedReturnDate,returnedAt,status,notes,lender,applicant,const DeepCollectionEquality().hash(_lendingCards),lendingDate);

@override
String toString() {
  return 'ShareCards(id: $id, title: $title, expectedReturnDate: $expectedReturnDate, returnedAt: $returnedAt, status: $status, notes: $notes, lender: $lender, applicant: $applicant, lendingCards: $lendingCards, lendingDate: $lendingDate)';
}


}

/// @nodoc
abstract mixin class _$ShareCardsCopyWith<$Res> implements $ShareCardsCopyWith<$Res> {
  factory _$ShareCardsCopyWith(_ShareCards value, $Res Function(_ShareCards) _then) = __$ShareCardsCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? title, DateTime? expectedReturnDate, DateTime? returnedAt, ShareCardsStatus? status, String? notes, String lender, String applicant,@JsonKey(fromJson: _lendingCardsFromJson, toJson: _lendingCardsToJson) List<MtgCard> lendingCards, DateTime? lendingDate
});




}
/// @nodoc
class __$ShareCardsCopyWithImpl<$Res>
    implements _$ShareCardsCopyWith<$Res> {
  __$ShareCardsCopyWithImpl(this._self, this._then);

  final _ShareCards _self;
  final $Res Function(_ShareCards) _then;

/// Create a copy of ShareCards
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? expectedReturnDate = freezed,Object? returnedAt = freezed,Object? status = freezed,Object? notes = freezed,Object? lender = null,Object? applicant = null,Object? lendingCards = null,Object? lendingDate = freezed,}) {
  return _then(_ShareCards(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,expectedReturnDate: freezed == expectedReturnDate ? _self.expectedReturnDate : expectedReturnDate // ignore: cast_nullable_to_non_nullable
as DateTime?,returnedAt: freezed == returnedAt ? _self.returnedAt : returnedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ShareCardsStatus?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,lender: null == lender ? _self.lender : lender // ignore: cast_nullable_to_non_nullable
as String,applicant: null == applicant ? _self.applicant : applicant // ignore: cast_nullable_to_non_nullable
as String,lendingCards: null == lendingCards ? _self._lendingCards : lendingCards // ignore: cast_nullable_to_non_nullable
as List<MtgCard>,lendingDate: freezed == lendingDate ? _self.lendingDate : lendingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
