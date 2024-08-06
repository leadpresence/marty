// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_cart_in_product_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ShopCartInProductState {
  bool get isLoading => throw _privateConstructorUsedError;
  CartData? get cartData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShopCartInProductStateCopyWith<ShopCartInProductState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopCartInProductStateCopyWith<$Res> {
  factory $ShopCartInProductStateCopyWith(ShopCartInProductState value,
          $Res Function(ShopCartInProductState) then) =
      _$ShopCartInProductStateCopyWithImpl<$Res, ShopCartInProductState>;
  @useResult
  $Res call({bool isLoading, CartData? cartData});
}

/// @nodoc
class _$ShopCartInProductStateCopyWithImpl<$Res,
        $Val extends ShopCartInProductState>
    implements $ShopCartInProductStateCopyWith<$Res> {
  _$ShopCartInProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? cartData = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      cartData: freezed == cartData
          ? _value.cartData
          : cartData // ignore: cast_nullable_to_non_nullable
              as CartData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShopCartInProductStateCopyWith<$Res>
    implements $ShopCartInProductStateCopyWith<$Res> {
  factory _$$_ShopCartInProductStateCopyWith(_$_ShopCartInProductState value,
          $Res Function(_$_ShopCartInProductState) then) =
      __$$_ShopCartInProductStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, CartData? cartData});
}

/// @nodoc
class __$$_ShopCartInProductStateCopyWithImpl<$Res>
    extends _$ShopCartInProductStateCopyWithImpl<$Res,
        _$_ShopCartInProductState>
    implements _$$_ShopCartInProductStateCopyWith<$Res> {
  __$$_ShopCartInProductStateCopyWithImpl(_$_ShopCartInProductState _value,
      $Res Function(_$_ShopCartInProductState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? cartData = freezed,
  }) {
    return _then(_$_ShopCartInProductState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      cartData: freezed == cartData
          ? _value.cartData
          : cartData // ignore: cast_nullable_to_non_nullable
              as CartData?,
    ));
  }
}

/// @nodoc

class _$_ShopCartInProductState extends _ShopCartInProductState {
  const _$_ShopCartInProductState({this.isLoading = false, this.cartData})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final CartData? cartData;

  @override
  String toString() {
    return 'ShopCartInProductState(isLoading: $isLoading, cartData: $cartData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShopCartInProductState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.cartData, cartData) ||
                other.cartData == cartData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, cartData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShopCartInProductStateCopyWith<_$_ShopCartInProductState> get copyWith =>
      __$$_ShopCartInProductStateCopyWithImpl<_$_ShopCartInProductState>(
          this, _$identity);
}

abstract class _ShopCartInProductState extends ShopCartInProductState {
  const factory _ShopCartInProductState(
      {final bool isLoading,
      final CartData? cartData}) = _$_ShopCartInProductState;
  const _ShopCartInProductState._() : super._();

  @override
  bool get isLoading;
  @override
  CartData? get cartData;
  @override
  @JsonKey(ignore: true)
  _$$_ShopCartInProductStateCopyWith<_$_ShopCartInProductState> get copyWith =>
      throw _privateConstructorUsedError;
}
