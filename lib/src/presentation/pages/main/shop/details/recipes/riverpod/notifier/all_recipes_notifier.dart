import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/utils/utils.dart';
import '../../../../../../../../models/models.dart';
import '../../../../../../../../repository/repository.dart';
import '../state/all_recipes_state.dart';

class AllRecipesNotifier extends StateNotifier<AllRecipesState> {
  final RecipesRepository _recipesRepository;
  int _page = 0;

  AllRecipesNotifier(this._recipesRepository) : super(const AllRecipesState());

  Future<void> fetchRecipes({VoidCallback? checkYourNetwork}) async {
    if (!state.hasMore) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (_page == 0) {
        state = state.copyWith(isLoading: true);
        final response =
            await _recipesRepository.getRecipesPaginate(page: ++_page);
        response.when(
          success: (data) {
            state = state.copyWith(
              isLoading: false,
              recipes: data.data ?? [],
              hasMore: (data.data ?? []).length >= 14,
            );
          },
          failure: (failure) {
            _page--;
            state = state.copyWith(isLoading: false, hasMore: false);
            debugPrint('==> get recipes failure: $failure');
          },
        );
      } else {
        state = state.copyWith(isMoreLoading: true);
        final response =
            await _recipesRepository.getRecipesPaginate(page: ++_page);
        response.when(
          success: (data) {
            final List<RecipeData> newList = List.from(state.recipes);
            newList.addAll(data.data ?? []);
            state = state.copyWith(
              isMoreLoading: false,
              recipes: newList,
              hasMore: (data.data ?? []).length >= 14,
            );
          },
          failure: (failure) {
            _page--;
            state = state.copyWith(isMoreLoading: false);
            debugPrint('==> get recipes failure: $failure');
          },
        );
      }
    } else {
      checkYourNetwork?.call();
    }
  }
}
