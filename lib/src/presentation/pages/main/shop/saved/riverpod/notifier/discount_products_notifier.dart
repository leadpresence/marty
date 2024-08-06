import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../models/models.dart';
import '../../../../../../../repository/repository.dart';
import '../state/discount_products_state.dart';

class DiscountProductsNotifier extends StateNotifier<DiscountProductsState> {
  final ProductsRepository _productsRepository;
  int _page = 0;

  DiscountProductsNotifier(this._productsRepository)
      : super(const DiscountProductsState());

  Future<void> likeOrUnlikeProduct({
    int? productId,
    int? shopId,
  }) async {
    final List<LocalProductData> likedProducts =
        LocalStorage.instance.getLikedProductsList();
    bool alreadyLiked = false;
    int indexLiked = 0;
    for (int i = 0; i < likedProducts.length; i++) {
      if (likedProducts[i].productId == productId) {
        alreadyLiked = true;
        indexLiked = i;
      }
    }
    if (alreadyLiked) {
      likedProducts.removeAt(indexLiked);
      LocalStorage.instance
          .setLikedProductsList(likedProducts.toSet().toList());
    } else {
      likedProducts.insert(
        0,
        LocalProductData(productId: productId ?? 0, shopId: shopId),
      );
      final setList = likedProducts.toSet().toList();
      final subList = setList.length > 16 ? setList.sublist(0, 16) : setList;
      LocalStorage.instance.setLikedProductsList(subList);
    }
    state = state.copyWith();
  }

  Future<void> fetchDiscountProducts({int? shopId}) async {
    if (!state.hasMore) {
      return;
    }
    if (_page == 0) {
      state = state.copyWith(isLoading: true);
      final response = await _productsRepository.getDiscountProducts(
        shopId: shopId,
        page: ++_page,
      );
      response.when(
        success: (data) {
          final List<ProductData> products = data.data ?? [];
          state = state.copyWith(
            isLoading: false,
            discountProducts: products,
            hasMore: products.length >= 14,
          );
        },
        failure: (failure) {
          _page--;
          state = state.copyWith(isLoading: false);
          debugPrint('==> get discount products failure: $failure');
        },
      );
    } else {
      state = state.copyWith(isMoreLoading: true);
      final response = await _productsRepository.getDiscountProducts(
        shopId: shopId,
        page: ++_page,
      );
      response.when(
        success: (data) {
          final List<ProductData> newList = List.from(state.discountProducts);
          final List<ProductData> products = data.data ?? [];
          newList.addAll(products);
          state = state.copyWith(
            isMoreLoading: false,
            discountProducts: newList,
            hasMore: products.length >= 14,
          );
        },
        failure: (failure) {
          _page--;
          state = state.copyWith(isLoading: false);
          debugPrint('==> get discount products failure: $failure');
        },
      );
    }
  }

  Future<void> updateDiscountProducts({int? shopId}) async {
    _page = 0;
    state = state.copyWith(hasMore: true, discountProducts: []);
    fetchDiscountProducts(shopId: shopId);
  }
}
