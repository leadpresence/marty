import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/discount_products_notifier.dart';
import '../state/discount_products_state.dart';

final discountProductsProvider =
    StateNotifierProvider<DiscountProductsNotifier, DiscountProductsState>(
  (ref) => DiscountProductsNotifier(productsRepository),
);
