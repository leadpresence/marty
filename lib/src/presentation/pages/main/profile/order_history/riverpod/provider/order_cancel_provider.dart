import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/order_cancel_notifier.dart';
import '../state/order_cancel_state.dart';

final orderCancelProvider =
    StateNotifierProvider.autoDispose<OrderCancelNotifier, OrderCancelState>(
  (ref) => OrderCancelNotifier(ordersRepository),
);
