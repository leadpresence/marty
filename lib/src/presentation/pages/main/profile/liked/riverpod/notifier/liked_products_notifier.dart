import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../models/models.dart';
import '../../../../../../../repository/repository.dart';
import '../state/liked_products_state.dart';

class LikedProductsNotifier extends StateNotifier<LikedProductsState> {
  final ProductsRepository _productsRepository;
  final CartsRepository _cartsRepository;
  Timer? _timer;

  LikedProductsNotifier(this._productsRepository, this._cartsRepository)
      : super(const LikedProductsState());

  void updateLikedProducts({CartData? cartData}) {
    List<ProductData> products = List.from(state.products);
    for (int i = 0; i < products.length; i++) {
      final int cartCount =
          AppHelpers.getProductCartCount(cartData, products[i]);
      products[i] =
          products[i].copyWith(cartCount: cartCount, localCartCount: cartCount);
    }
    state = state.copyWith(products: products);
  }

  void decreaseProductCount({
    required int productIndex,
    int? shopId,
    Function(CartData?)? onCartUpdate,
  }) {
    final List<ProductData> products = List.from(state.products);
    final product = products[productIndex];
    if ((product.localCartCount ?? 0) <= (product.minQty ?? 0)) {
      return;
    }
    final int localCartCount = product.localCartCount ?? 0;
    products[productIndex] =
        product.copyWith(localCartCount: localCartCount - 1);
    state = state.copyWith(products: products);
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
    required int productIndex,
    int? shopId,
    Function(CartData?)? onCartUpdate,
  }) async {
    final ProductData product = state.products[productIndex];
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
    final List<ProductData> products = List.from(state.products);
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
    state = state.copyWith(products: products);
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

  Future<void> fetchLikedProducts({int? shopId, CartData? cartData}) async {
    final List<LocalProductData> products =
        LocalStorage.instance.getLikedProductsList();
    final List<LocalProductData> filteredLocalProducts = [];
    for (final product in products) {
      if (product.shopId == shopId) {
        filteredLocalProducts.add(product);
      }
    }
    if (filteredLocalProducts.isEmpty) {
      return;
    }
    state = state.copyWith(isLoading: true);
    final response =
        await _productsRepository.getProductsByIds(filteredLocalProducts);
    response.when(
      success: (data) {
        final List<ProductData> likedProducts = data.data ?? [];
        final List<ProductData> filtered = [];
        for (final product in filteredLocalProducts) {
          for (final likedProduct in likedProducts) {
            if (product.productId == likedProduct.id) {
              filtered.add(likedProduct);
            }
          }
        }
        for (int i = 0; i < filtered.length; i++) {
          final int cartCount =
              AppHelpers.getProductCartCount(cartData, filtered[i]);
          if (cartCount != 0) {
            filtered[i] = filtered[i].copyWith(
              cartCount: cartCount,
              localCartCount: cartCount,
            );
          }
        }
        state = state.copyWith(products: filtered, isLoading: false);
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get liked products failure: $failure');
      },
    );
  }

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
}
