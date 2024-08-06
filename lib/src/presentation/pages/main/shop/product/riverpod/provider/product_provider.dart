import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/product_notifier.dart';
import '../state/product_state.dart';

final productProvider =
    StateNotifierProvider.autoDispose<ProductNotifier, ProductState>(
  (ref) => ProductNotifier(productsRepository, cartRepository),
);
