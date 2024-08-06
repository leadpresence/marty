import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/all_recipe_categories_notifier.dart';
import '../state/all_recipe_categories_state.dart';

final allRecipeCategoriesProvider = StateNotifierProvider.autoDispose<
    AllRecipeCategoriesNotifier, AllRecipeCategoriesState>(
  (ref) => AllRecipeCategoriesNotifier(recipesRepository),
);
