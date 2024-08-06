import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/product_cart_count_notifier.dart';
import '../state/product_cart_count_state.dart';

final productCartCountProvider =
    StateNotifierProvider<ProductCartCountNotifier, ProductCartCountState>(
  (ref) => ProductCartCountNotifier(cartRepository),
);
