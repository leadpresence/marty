import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/product_review_notifier.dart';
import '../state/product_review_state.dart';

final productReviewProvider = StateNotifierProvider.autoDispose<
    ProductReviewNotifier, ProductReviewState>(
  (ref) => ProductReviewNotifier(productsRepository, settingsRepository),
);
