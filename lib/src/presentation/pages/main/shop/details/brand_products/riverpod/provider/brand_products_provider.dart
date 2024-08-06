import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/brand_products_notifier.dart';
import '../state/brand_products_state.dart';

final brandProductsProvider =
    StateNotifierProvider<BrandProductsNotifier, BrandProductsState>(
  (ref) => BrandProductsNotifier(productsRepository),
);
