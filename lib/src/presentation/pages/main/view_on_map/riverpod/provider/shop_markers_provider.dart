import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/shop_markers_notifier.dart';
import '../state/shop_markers_state.dart';

final shopMarkersProvider =
    StateNotifierProvider<ShopMarkersNotifier, ShopMarkersState>(
  (ref) => ShopMarkersNotifier(),
);
