import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/search_product_in_category_details_notifier.dart';
import '../state/search_product_in_category_details_state.dart';

final searchProductInCategoryDetailsProvider =
    StateNotifierProvider.autoDispose<SearchProductInCategoryDetailsNotifier,
        SearchProductInCategoryDetailsState>(
  (ref) => SearchProductInCategoryDetailsNotifier(
    productsRepository,
    cartRepository,
  ),
);
