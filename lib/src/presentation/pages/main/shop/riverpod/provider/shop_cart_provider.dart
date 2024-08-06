import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependency_manager.dart';
import '../notifier/shop_cart_notifier.dart';
import '../state/shop_cart_state.dart';

final shopCartProvider = StateNotifierProvider<ShopCartNotifier, ShopCartState>(
  (ref) => ShopCartNotifier(cartRepository),
);
