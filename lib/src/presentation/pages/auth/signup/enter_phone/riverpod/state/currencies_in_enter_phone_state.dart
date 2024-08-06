import 'package:freezed_annotation/freezed_annotation.dart';

part 'currencies_in_enter_phone_state.freezed.dart';

@freezed
class CurrenciesInEnterPhoneState with _$CurrenciesInEnterPhoneState {
  const factory CurrenciesInEnterPhoneState({@Default(false) bool isLoading}) =
      _CurrenciesInEnterPhoneState;

  const CurrenciesInEnterPhoneState._();
}
