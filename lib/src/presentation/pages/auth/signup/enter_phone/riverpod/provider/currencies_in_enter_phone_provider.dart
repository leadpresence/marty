import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/currencies_in_enter_phone_notifier.dart';
import '../state/currencies_in_enter_phone_state.dart';

final currenciesInEnterPhoneProvider = StateNotifierProvider.autoDispose<
    CurrenciesInEnterPhoneNotifier, CurrenciesInEnterPhoneState>(
  (ref) => CurrenciesInEnterPhoneNotifier(settingsRepository),
);
