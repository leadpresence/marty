import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependency_manager.dart';
import '../notifier/shops_in_map_notifier.dart';
import '../state/shops_in_map_state.dart';

final shopsInMapProvider =
    StateNotifierProvider<ShopsInMapNotifier, ShopsInMapState>(
  (ref) => ShopsInMapNotifier(shopsRepository),
);
