import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/search_product_in_category_products_notifier.dart';
import '../state/search_product_in_category_products_state.dart';

final searchProductInCategoryProductsProvider = StateNotifierProvider<
    SearchProductInCategoryProductsNotifier,
    SearchProductInCategoryProductsState>(
  (ref) => SearchProductInCategoryProductsNotifier(productsRepository),
);
