// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ingredients_to_cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IngredientsToCartState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get added => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IngredientsToCartStateCopyWith<IngredientsToCartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientsToCartStateCopyWith<$Res> {
  factory $IngredientsToCartStateCopyWith(IngredientsToCartState value,
          $Res Function(IngredientsToCartState) then) =
      _$IngredientsToCartStateCopyWithImpl<$Res, IngredientsToCartState>;
  @useResult
  $Res call({bool isLoading, bool added});
}

/// @nodoc
class _$IngredientsToCartStateCopyWithImpl<$Res,
        $Val extends IngredientsToCartState>
    implements $IngredientsToCartStateCopyWith<$Res> {
  _$IngredientsToCartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? added = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      added: null == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IngredientsToCartStateCopyWith<$Res>
    implements $IngredientsToCartStateCopyWith<$Res> {
  factory _$$_IngredientsToCartStateCopyWith(_$_IngredientsToCartState value,
          $Res Function(_$_IngredientsToCartState) then) =
      __$$_IngredientsToCartStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, bool added});
}

/// @nodoc
class __$$_IngredientsToCartStateCopyWithImpl<$Res>
    extends _$IngredientsToCartStateCopyWithImpl<$Res,
        _$_IngredientsToCartState>
    implements _$$_IngredientsToCartStateCopyWith<$Res> {
  __$$_IngredientsToCartStateCopyWithImpl(_$_IngredientsToCartState _value,
      $Res Function(_$_IngredientsToCartState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? added = null,
  }) {
    return _then(_$_IngredientsToCartState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      added: null == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_IngredientsToCartState extends _IngredientsToCartState {
  const _$_IngredientsToCartState({this.isLoading = false, this.added = false})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool added;

  @override
  String toString() {
    return 'IngredientsToCartState(isLoading: $isLoading, added: $added)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IngredientsToCartState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.added, added) || other.added == added));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, added);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IngredientsToCartStateCopyWith<_$_IngredientsToCartState> get copyWith =>
      __$$_IngredientsToCartStateCopyWithImpl<_$_IngredientsToCartState>(
          this, _$identity);
}

abstract class _IngredientsToCartState extends IngredientsToCartState {
  const factory _IngredientsToCartState(
      {final bool isLoading, final bool added}) = _$_IngredientsToCartState;
  const _IngredientsToCartState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get added;
  @override
  @JsonKey(ignore: true)
  _$$_IngredientsToCartStateCopyWith<_$_IngredientsToCartState> get copyWith =>
      throw _privateConstructorUsedError;
}
