import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/coupon_products_notifier.dart';
import '../state/coupon_products_state.dart';

final couponProductsProvider =
    StateNotifierProvider<CouponProductsNotifier, CouponProductsState>(
  (ref) => CouponProductsNotifier(productsRepository),
);
