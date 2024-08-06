import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/utils/utils.dart';
import '../../../../../../../../models/models.dart';
import '../../../../../../../../repository/repository.dart';
import '../state/search_product_in_category_details_state.dart';

class SearchProductInCategoryDetailsNotifier
    extends StateNotifier<SearchProductInCategoryDetailsState> {
  final ProductsRepository _productsRepository;
  final CartsRepository _cartsRepository;
  Timer? _timer;

  SearchProductInCategoryDetailsNotifier(
    this._productsRepository,
    this._cartsRepository,
  ) : super(const SearchProductInCategoryDetailsState());

  void decreaseProductCount({
    required int productIndex,
    int? shopId,
    Function(CartData?)? onCartUpdate,
  }) {
    final List<ProductData> products = List.from(state.searchedProducts);
    final product = products[productIndex];
    if ((product.localCartCount ?? 0) <= (product.minQty ?? 0)) {
      return;
    }
    final int localCartCount = product.localCartCount ?? 0;
    products[productIndex] =
        product.copyWith(localCartCount: localCartCount - 1);
    state = state.copyWith(searchedProducts: products);
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 300),
      () {
        _updateRemoteCart(
          productIndex: productIndex,
          shopId: shopId,
          onCartUpdate: onCartUpdate,
        );
      },
    );
  }

  Future<void> _updateRemoteCart({
    int? productIndex,
    int? shopId,
    Function(CartData?)? onCartUpdate,
  }) async {
    if (productIndex == null) {
      return;
    }
    final ProductData product = state.searchedProducts[productIndex];
    if (product.localCartCount == null || product.localCartCount == 0) {
      return;
    }
    final response = await _cartsRepository.saveProductToCart(
      shopId: shopId,
      productId: product.id,
      quantity: product.localCartCount,
    );
    response.when(
      success: (data) {
        if (onCartUpdate != null) {
          onCartUpdate(data.data);
        }
      },
      failure: (failure) {
        debugPrint('==> save to cart failure: $failure');
      },
    );
  }

  void increaseProductCount({
    required int productIndex,
    int? shopId,
    Function(CartData?)? onCartUpdate,
  }) {
    final List<ProductData> products = List.from(state.searchedProducts);
    final product = products[productIndex];
    if ((product.localCartCount ?? 0) >= (product.maxQty ?? 0) ||
        (product.localCartCount ?? 0) >= (product.quantity ?? 0)) {
      return;
    }
    final int localCartCount = product.localCartCount ?? 0;
    products[productIndex] = product.copyWith(
      localCartCount:
          localCartCount == 0 ? product.minQty : (localCartCount + 1),
    );
    state = state.copyWith(searchedProducts: products);
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 300),
      () {
        _updateRemoteCart(
          productIndex: productIndex,
          shopId: shopId,
          onCartUpdate: onCartUpdate,
        );
      },
    );
  }

  Future<void> likeOrUnlikeProduct({int? productId, int? shopId}) async {
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

  void setQuery(String query, {CartData? cartData, int? shopId}) {
    if (state.query == query) {
      return;
    }
    state = state.copyWith(query: query.trim());
    if (state.query.isNotEmpty) {
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      }
      _timer = Timer(
        const Duration(milliseconds: 500),
        () {
          searchProducts(cartData: cartData, shopId: shopId);
        },
      );
    } else {
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      }
      _timer = Timer(
        const Duration(milliseconds: 500),
        () {
          state = state.copyWith(isSearching: false);
        },
      );
    }
  }

  Future<void> searchProducts({CartData? cartData, int? shopId}) async {
    state = state.copyWith(isSearchLoading: true, isSearching: true);
    final response = await _productsRepository.searchProducts(
      query: state.query,
      shopId: shopId,
    );
    response.when(
      success: (data) {
        final List<ProductData> products = data.data ?? [];
        for (int i = 0; i < products.length; i++) {
          final int cartCount =
              AppHelpers.getProductCartCount(cartData, products[i]);
          if (cartCount != 0) {
            products[i] = products[i].copyWith(
              cartCount: cartCount,
              localCartCount: cartCount,
            );
          }
        }
        state =
            state.copyWith(isSearchLoading: false, searchedProducts: products);
      },
      failure: (failure) {
        state = state.copyWith(isSearchLoading: false);
        debugPrint('==> search products failure: $failure');
      },
    );
  }
}
