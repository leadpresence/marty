// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_cart_count_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProductCartCountState {
  ProductData? get product => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductCartCountStateCopyWith<ProductCartCountState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCartCountStateCopyWith<$Res> {
  factory $ProductCartCountStateCopyWith(ProductCartCountState value,
          $Res Function(ProductCartCountState) then) =
      _$ProductCartCountStateCopyWithImpl<$Res, ProductCartCountState>;
  @useResult
  $Res call({ProductData? product});
}

/// @nodoc
class _$ProductCartCountStateCopyWithImpl<$Res,
        $Val extends ProductCartCountState>
    implements $ProductCartCountStateCopyWith<$Res> {
  _$ProductCartCountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProductCartCountStateCopyWith<$Res>
    implements $ProductCartCountStateCopyWith<$Res> {
  factory _$$_ProductCartCountStateCopyWith(_$_ProductCartCountState value,
          $Res Function(_$_ProductCartCountState) then) =
      __$$_ProductCartCountStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ProductData? product});
}

/// @nodoc
class __$$_ProductCartCountStateCopyWithImpl<$Res>
    extends _$ProductCartCountStateCopyWithImpl<$Res, _$_ProductCartCountState>
    implements _$$_ProductCartCountStateCopyWith<$Res> {
  __$$_ProductCartCountStateCopyWithImpl(_$_ProductCartCountState _value,
      $Res Function(_$_ProductCartCountState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = freezed,
  }) {
    return _then(_$_ProductCartCountState(
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductData?,
    ));
  }
}

/// @nodoc

class _$_ProductCartCountState extends _ProductCartCountState {
  const _$_ProductCartCountState({this.product}) : super._();

  @override
  final ProductData? product;

  @override
  String toString() {
    return 'ProductCartCountState(product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductCartCountState &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(runtimeType, product);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductCartCountStateCopyWith<_$_ProductCartCountState> get copyWith =>
      __$$_ProductCartCountStateCopyWithImpl<_$_ProductCartCountState>(
          this, _$identity);
}

abstract class _ProductCartCountState extends ProductCartCountState {
  const factory _ProductCartCountState({final ProductData? product}) =
      _$_ProductCartCountState;
  const _ProductCartCountState._() : super._();

  @override
  ProductData? get product;
  @override
  @JsonKey(ignore: true)
  _$$_ProductCartCountStateCopyWith<_$_ProductCartCountState> get copyWith =>
      throw _privateConstructorUsedError;
}
