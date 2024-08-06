import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/search_product_in_brand_notifier.dart';
import '../state/search_product_in_brand_state.dart';

final searchProductInBrandProvider = StateNotifierProvider<
    SearchProductInBrandNotifier, SearchProductInBrandState>(
  (ref) => SearchProductInBrandNotifier(productsRepository),
);
