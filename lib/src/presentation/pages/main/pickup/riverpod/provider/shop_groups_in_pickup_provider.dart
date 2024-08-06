import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependency_manager.dart';
import '../notifier/shop_groups_in_pickup_notifier.dart';
import '../state/shop_groups_in_pickup_state.dart';

final shopGroupsInPickupProvider =
    StateNotifierProvider<ShopGroupsInPickupNotifier, ShopGroupsInPickupState>(
  (ref) => ShopGroupsInPickupNotifier(shopsRepository),
);
