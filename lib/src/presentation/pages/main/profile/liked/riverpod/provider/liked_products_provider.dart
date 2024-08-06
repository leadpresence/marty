import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/liked_products_notifier.dart';
import '../state/liked_products_state.dart';

final likedProductsProvider = StateNotifierProvider.autoDispose<
    LikedProductsNotifier, LikedProductsState>(
  (ref) => LikedProductsNotifier(productsRepository, cartRepository),
);
