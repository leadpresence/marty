import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/new_orders_notifier.dart';
import '../state/new_orders_state.dart';

final newOrdersProvider =
    StateNotifierProvider.autoDispose<NewOrdersNotifier, NewOrdersState>(
  (ref) => NewOrdersNotifier(ordersRepository),
);
