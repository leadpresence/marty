import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/view_on_map_notifier.dart';
import '../state/view_on_map_state.dart';

final viewOnMapProvider =
    StateNotifierProvider<ViewOnMapNotifier, ViewOnMapState>(
  (ref) => ViewOnMapNotifier(),
);
