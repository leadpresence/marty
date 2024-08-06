import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/delivered_orders_notifier.dart';
import '../state/delivered_orders_state.dart';

final deliveredOrdersProvider = StateNotifierProvider.autoDispose<
    DeliveredOrdersNotifier, DeliveredOrdersState>(
  (ref) => DeliveredOrdersNotifier(ordersRepository),
);
