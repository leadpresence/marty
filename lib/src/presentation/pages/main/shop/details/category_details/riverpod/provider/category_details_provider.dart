import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/category_details_notifier.dart';
import '../state/category_details_state.dart';

final categoryDetailsProvider =
    StateNotifierProvider<CategoryDetailsNotifier, CategoryDetailsState>(
  (ref) => CategoryDetailsNotifier(productsRepository, cartRepository),
);
