import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependency_manager.dart';
import '../notifier/currencies_in_login_notifier.dart';
import '../state/currencies_in_login_state.dart';

final currenciesInLoginProvider = StateNotifierProvider.autoDispose<
    CurrenciesInLoginNotifier, CurrenciesInLoginState>(
  (ref) => CurrenciesInLoginNotifier(settingsRepository),
);
