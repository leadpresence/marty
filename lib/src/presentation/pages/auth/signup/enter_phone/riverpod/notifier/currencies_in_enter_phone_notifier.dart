import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../models/models.dart';
import '../../../../../../../repository/repository.dart';
import '../state/currencies_in_enter_phone_state.dart';

class CurrenciesInEnterPhoneNotifier
    extends StateNotifier<CurrenciesInEnterPhoneState> {
  final SettingsRepository _settingsRepository;

  CurrenciesInEnterPhoneNotifier(this._settingsRepository)
      : super(const CurrenciesInEnterPhoneState());

  Future<void> fetchCurrencies({
    VoidCallback? checkYourNetwork,
    VoidCallback? afterFetched,
  }) async {
    if (await AppConnectivity.connectivity()) {
      state = state.copyWith(isLoading: true);
      final response = await _settingsRepository.getCurrencies();
      response.when(
        success: (data) async {
          int defaultCurrencyIndex = 0;
          final List<CurrencyData> currencies = data.data ?? [];
          for (int i = 0; i < currencies.length; i++) {
            if (currencies[i].isDefault ?? false) {
              defaultCurrencyIndex = i;
              break;
            }
          }
          LocalStorage.instance
              .setSelectedCurrency(currencies[defaultCurrencyIndex]);
          state = state.copyWith(isLoading: false);
          afterFetched?.call();
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get currency failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}
