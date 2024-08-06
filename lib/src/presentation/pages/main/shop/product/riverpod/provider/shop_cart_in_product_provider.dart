import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/shop_cart_in_product_notifier.dart';
import '../state/shop_cart_in_product_state.dart';

final shopCartInProductProvider =
    StateNotifierProvider<ShopCartInProductNotifier, ShopCartInProductState>(
  (ref) => ShopCartInProductNotifier(cartRepository),
);
