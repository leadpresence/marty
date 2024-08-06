import 'package:freezed_annotation/freezed_annotation.dart';

part 'currencies_in_login_state.freezed.dart';

@freezed
class CurrenciesInLoginState with _$CurrenciesInLoginState {
  const factory CurrenciesInLoginState({@Default(false) bool isLoading}) =
      _CurrenciesInLoginState;

  const CurrenciesInLoginState._();
}
