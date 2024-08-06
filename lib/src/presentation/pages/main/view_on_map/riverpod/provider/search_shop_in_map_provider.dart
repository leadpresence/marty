import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependency_manager.dart';
import '../notifier/search_shop_in_map_notifier.dart';
import '../state/search_shop_in_map_state.dart';

final searchShopInMapProvider =
    StateNotifierProvider<SearchShopInMapNotifier, SearchShopInMapState>(
  (ref) => SearchShopInMapNotifier(shopsRepository),
);
