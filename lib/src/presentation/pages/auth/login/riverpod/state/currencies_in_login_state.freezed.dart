// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currencies_in_login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CurrenciesInLoginState {
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CurrenciesInLoginStateCopyWith<CurrenciesInLoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrenciesInLoginStateCopyWith<$Res> {
  factory $CurrenciesInLoginStateCopyWith(CurrenciesInLoginState value,
          $Res Function(CurrenciesInLoginState) then) =
      _$CurrenciesInLoginStateCopyWithImpl<$Res, CurrenciesInLoginState>;
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class _$CurrenciesInLoginStateCopyWithImpl<$Res,
        $Val extends CurrenciesInLoginState>
    implements $CurrenciesInLoginStateCopyWith<$Res> {
  _$CurrenciesInLoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CurrenciesInLoginStateCopyWith<$Res>
    implements $CurrenciesInLoginStateCopyWith<$Res> {
  factory _$$_CurrenciesInLoginStateCopyWith(_$_CurrenciesInLoginState value,
          $Res Function(_$_CurrenciesInLoginState) then) =
      __$$_CurrenciesInLoginStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class __$$_CurrenciesInLoginStateCopyWithImpl<$Res>
    extends _$CurrenciesInLoginStateCopyWithImpl<$Res,
        _$_CurrenciesInLoginState>
    implements _$$_CurrenciesInLoginStateCopyWith<$Res> {
  __$$_CurrenciesInLoginStateCopyWithImpl(_$_CurrenciesInLoginState _value,
      $Res Function(_$_CurrenciesInLoginState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
  }) {
    return _then(_$_CurrenciesInLoginState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CurrenciesInLoginState extends _CurrenciesInLoginState {
  const _$_CurrenciesInLoginState({this.isLoading = false}) : super._();

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'CurrenciesInLoginState(isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CurrenciesInLoginState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CurrenciesInLoginStateCopyWith<_$_CurrenciesInLoginState> get copyWith =>
      __$$_CurrenciesInLoginStateCopyWithImpl<_$_CurrenciesInLoginState>(
          this, _$identity);
}

abstract class _CurrenciesInLoginState extends CurrenciesInLoginState {
  const factory _CurrenciesInLoginState({final bool isLoading}) =
      _$_CurrenciesInLoginState;
  const _CurrenciesInLoginState._() : super._();

  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_CurrenciesInLoginStateCopyWith<_$_CurrenciesInLoginState> get copyWith =>
      throw _privateConstructorUsedError;
}
