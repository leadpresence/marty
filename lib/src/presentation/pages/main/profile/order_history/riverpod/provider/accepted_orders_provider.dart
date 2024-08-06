import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/accepted_orders_notifier.dart';
import '../state/accepted_orders_state.dart';

final acceptedOrdersProvider = StateNotifierProvider.autoDispose<
    AcceptedOrdersNotifier, AcceptedOrdersState>(
  (ref) => AcceptedOrdersNotifier(ordersRepository),
);
