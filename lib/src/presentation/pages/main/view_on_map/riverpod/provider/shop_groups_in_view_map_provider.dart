import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/shop_groups_in_view_map_notifier.dart';
import '../state/shop_groups_in_view_map_state.dart';

final shopGroupsInViewMapProvider = StateNotifierProvider<
    ShopGroupsInViewMapNotifier, ShopGroupsInViewMapState>(
  (ref) => ShopGroupsInViewMapNotifier(),
);
