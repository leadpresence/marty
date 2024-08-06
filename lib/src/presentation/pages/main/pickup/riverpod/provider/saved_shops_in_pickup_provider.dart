import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependency_manager.dart';
import '../notifier/saved_shops_in_pickup_notifier.dart';
import '../state/saved_shops_in_pickup_state.dart';

final savedShopsInPickupProvider =
    StateNotifierProvider<SavedShopsInPickupNotifier, SavedShopsInPickupState>(
  (ref) => SavedShopsInPickupNotifier(shopsRepository),
);
