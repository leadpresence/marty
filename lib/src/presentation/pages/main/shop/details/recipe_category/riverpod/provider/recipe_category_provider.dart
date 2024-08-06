import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/recipe_category_notifier.dart';
import '../state/recipe_category_state.dart';

final recipeCategoryProvider = StateNotifierProvider.autoDispose<
    RecipeCategoryNotifier, RecipeCategoryState>(
  (ref) => RecipeCategoryNotifier(recipesRepository),
);
