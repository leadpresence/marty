import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/ready_orders_notifier.dart';
import '../state/ready_orders_state.dart';

final readyOrdersProvider =
    StateNotifierProvider.autoDispose<ReadyOrdersNotifier, ReadyOrdersState>(
  (ref) => ReadyOrdersNotifier(ordersRepository),
);
