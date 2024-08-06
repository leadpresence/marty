import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/currencies_notifier.dart';
import '../state/currencies_state.dart';

final currenciesProvider =
    StateNotifierProvider.autoDispose<CurrenciesNotifier, CurrenciesState>(
  (ref) => CurrenciesNotifier(settingsRepository),
);
