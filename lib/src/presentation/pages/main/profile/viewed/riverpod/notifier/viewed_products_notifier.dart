import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../models/models.dart';
import '../../../../../../../repository/repository.dart';
import '../state/viewed_products_state.dart';

class ViewedProductsNotifier extends StateNotifier<ViewedProductsState> {
  final ProductsRepository _productsRepository;
  final CartsRepository _cartsRepository;
  Timer? _timer;
  int? _activeProductIndex;

  ViewedProductsNotifier(this._productsRepository, this._cartsRepository)
      : super(const ViewedProductsState());

  void decreaseProductCount({required int index, int? shopId}) {
    final List<ProductData> products = List.from(state.products);
    final product = products[index];
    if ((product.localCartCount ?? 0) <= (product.minQty ?? 0)) {
      return;
    }
    final int localCartCount = product.localCartCount ?? 0;
    products[index] = product.copyWith(localCartCount: localCartCount - 1);
    state = state.copyWith(products: products);
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 4000),
      () {
        // products[index] = products[index].copyWith(isChoosing: false);
        state = state.copyWith(products: products);
        _updateRemoteCart(index: _activeProductIndex, shopId: shopId);
        _activeProductIndex = null;
      },
    );
  }

  void increaseProductCount({required int index, int? shopId}) {
    final List<ProductData> products = List.from(state.products);
    final product = products[index];
    if ((product.localCartCount ?? 0) >= (product.maxQty ?? 0) ||
        (product.localCartCount ?? 0) >= (product.quantity ?? 0)) {
      return;
    }
    final int localCartCount = product.localCartCount ?? 0;
    products[index] = product.copyWith(
      localCartCount:
          localCartCount == 0 ? product.minQty : (localCartCount + 1),
    );
    state = state.copyWith(products: products);
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 4000),
      () {
        // products[index] = products[index].copyWith(isChoosing: false);
        state = state.copyWith(products: products);
        _updateRemoteCart(index: _activeProductIndex, shopId: shopId);
        _activeProductIndex = null;
      },
    );
  }

  void _updateLoadingProduct(bool value, {required int index}) {
    List<ProductData> products = List.from(state.products);
    products[index] = products[index].copyWith(isLoading: value);
    state = state.copyWith(products: products);
  }

  Future<void> _updateRemoteCart({int? shopId, int? index}) async {
    if (index == null) {
      return;
    }
    final ProductData product = state.products[index];
    if (product.localCartCount == null || product.localCartCount == 0) {
      return;
    }
    _updateLoadingProduct(true, index: index);
    final response = await _cartsRepository.saveProductToCart(
      shopId: shopId,
      productId: product.id,
      quantity: product.localCartCount,
    );
    response.when(
      success: (data) {
        _updateLoadingProduct(false, index: index);
      },
      failure: (failure) {
        debugPrint('==> save to cart failure: $failure');
        _updateLoadingProduct(false, index: index);
      },
    );
  }

  void updateChoosing({int? shopId, required int index}) {
    List<ProductData> products = List.from(state.products);
    // for (int i = 0; i < products.length; i++) {
    //   products[i] = products[i].copyWith(isChoosing: false);
    // }
    _timer?.cancel();
    // products[index] = products[index].copyWith(isChoosing: true);
    _updateRemoteCart(shopId: shopId);
    _activeProductIndex = index;
    _timer = Timer(
      const Duration(milliseconds: 4000),
      () {
        // products[index] = products[index].copyWith(isChoosing: false);
        state = state.copyWith(products: products);
        _updateRemoteCart(index: _activeProductIndex, shopId: shopId);
        _activeProductIndex = null;
      },
    );
    state = state.copyWith(products: products);
  }

  Future<void> fetchViewedProducts({
    VoidCallback? checkYourNetwork,
    int? shopId,
  }) async {
    final List<LocalProductData> products =
        LocalStorage.instance.getViewedProductsList();
    final List<LocalProductData> filteredLocalProducts = [];
    for (final product in products) {
      if (product.shopId == shopId) {
        filteredLocalProducts.add(product);
      }
    }
    if (filteredLocalProducts.isEmpty) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response =
          await _productsRepository.getProductsByIds(filteredLocalProducts);
      response.when(
        success: (data) {
          final List<ProductData> viewedProducts = data.data ?? [];
          final List<ProductData> filtered = [];
          for (final product in viewedProducts) {
            for (final localProduct in filteredLocalProducts) {
              if (product.id == localProduct.productId) {
                filtered.add(product);
              }
            }
          }
          state = state.copyWith(products: filtered, isLoading: false);
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get viewed products failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
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
