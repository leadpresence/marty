import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../models/models.dart';
import '../../../../../../../repository/repository.dart';
import '../state/related_products_state.dart';

class RelatedProductsNotifier extends StateNotifier<RelatedProductsState> {
  final ProductsRepository _productsRepository;
  final CartsRepository _cartsRepository;
  int? _activeProductIndex;
  Timer? _timer;

  RelatedProductsNotifier(this._productsRepository, this._cartsRepository)
      : super(const RelatedProductsState()) {
    _activeProductIndex = null;
  }

  void decreaseProductCount({required int productIndex}) {
    final List<ProductData> products = List.from(state.relatedProducts);
    final product = products[productIndex];
    if ((product.localCartCount ?? 0) <= (product.minQty ?? 0)) {
      return;
    }
    final int localCartCount = product.localCartCount ?? 0;
    products[productIndex] = product.copyWith(
      localCartCount: localCartCount - 1,
    );
    state = state.copyWith(relatedProducts: products);
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 4000),
      () {
        // products[productIndex] =
        //     products[productIndex].copyWith(isChoosing: false);
        state = state.copyWith(relatedProducts: products);
        _updateRemoteCart(productIndex: _activeProductIndex);
        _activeProductIndex = null;
      },
    );
  }

  void increaseProductCount({required int productIndex}) {
    final List<ProductData> products = List.from(state.relatedProducts);
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
    state = state.copyWith(relatedProducts: products);
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 4000),
      () {
        // products[productIndex] =
        //     products[productIndex].copyWith(isChoosing: false);
        state = state.copyWith(relatedProducts: products);
        _updateRemoteCart(productIndex: _activeProductIndex);
        _activeProductIndex = null;
      },
    );
  }

  void _updateLoadingProduct(bool value, {int? productIndex}) {
    final List<ProductData> products = List.from(state.relatedProducts);
    products[productIndex!] = products[productIndex].copyWith(isLoading: value);
    state = state.copyWith(relatedProducts: products);
  }

  Future<void> _updateRemoteCart({int? productIndex}) async {
    if (productIndex == null) {
      return;
    }
    final ProductData product = state.relatedProducts[productIndex];
    if (product.localCartCount == null || product.localCartCount == 0) {
      return;
    }
    _updateLoadingProduct(true, productIndex: productIndex);
    final response = await _cartsRepository.saveProductToCart(
      shopId: product.shopId,
      productId: product.id,
      quantity: product.localCartCount,
    );
    response.when(
      success: (data) {
        _updateLoadingProduct(false, productIndex: productIndex);
      },
      failure: (failure) {
        debugPrint('==> save to cart failure: $failure');
        _updateLoadingProduct(false, productIndex: productIndex);
      },
    );
  }

  void updateChoosing({required int productIndex}) {
    List<ProductData> related = List.from(state.relatedProducts);
    // for (int i = 0; i < related.length; i++) {
    //   related[i] = related[i].copyWith(isChoosing: false);
    // }
    _timer?.cancel();
    // related[productIndex] = related[productIndex].copyWith(isChoosing: true);
    state = state.copyWith(relatedProducts: related);
    _updateRemoteCart(productIndex: _activeProductIndex);
    _activeProductIndex = productIndex;
    _timer = Timer(
      const Duration(milliseconds: 4000),
      () {
        // related[productIndex] =
        //     related[productIndex].copyWith(isChoosing: false);
        state = state.copyWith(relatedProducts: related);
        _updateRemoteCart(productIndex: _activeProductIndex);
        _activeProductIndex = null;
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

  Future<void> fetchRelatedProducts({
    int? shopId,
    int? productId,
    int? categoryId,
    int? brandId,
    CartData? cartData,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.searchProducts(
      shopId: shopId,
      categoryId: categoryId,
      brandId: brandId,
    );
    response.when(
      success: (data) {
        final List<ProductData> filtered = [];
        for (final related in (data.data ?? [])) {
          if (related.id == productId) {
            continue;
          }
          filtered.add(related);
        }
        for (int i = 0; i < filtered.length; i++) {
          final int cartCount = AppHelpers.getProductCartCount(
            cartData,
            filtered[i],
          );
          if (cartCount != 0) {
            filtered[i] = filtered[i].copyWith(
              cartCount: cartCount,
              localCartCount: cartCount,
            );
          }
        }
        state = state.copyWith(relatedProducts: filtered, isLoading: false);
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get related products failure: $failure');
      },
    );
  }
}
