import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/utils/utils.dart';
import '../../../../../../../../models/models.dart';
import '../../../../../../../../repository/repository.dart';
import '../state/category_details_state.dart';

class CategoryDetailsNotifier extends StateNotifier<CategoryDetailsState> {
  final ProductsRepository _productsRepository;
  final CartsRepository _cartsRepository;
  int _page = 0;
  Timer? _timer;

  CategoryDetailsNotifier(this._productsRepository, this._cartsRepository)
      : super(const CategoryDetailsState());

  Future<void> _updateRemoteCart({
    int? productIndex,
    int? shopId,
    Function(CartData?)? onCartUpdate,
  }) async {
    if (productIndex == null) {
      return;
    }
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

  void likeOrUnlikeProduct({int? productId, int? shopId}) {
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

  Future<void> fetchCategoryProducts({
    int? categoryId,
    int? shopId,
    CartData? cartData,
  }) async {
    if (!state.hasMore) {
      return;
    }
    if (_page == 0) {
      state = state.copyWith(isLoading: true);
      final response = await _productsRepository.getProductsPaginate(
        page: ++_page,
        categoryId: categoryId,
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
          state = state.copyWith(
            isLoading: false,
            products: products,
            hasMore: products.length >= 10,
          );
        },
        failure: (failure) {
          _page--;
          state = state.copyWith(isLoading: false, hasMore: false);
          debugPrint('==> get category products failure: $failure');
        },
      );
    } else {
      state = state.copyWith(isMoreLoading: true);
      final response = await _productsRepository.getProductsPaginate(
        page: ++_page,
        categoryId: categoryId,
        shopId: shopId,
      );
      response.when(
        success: (data) {
          final List<ProductData> products = List.from(state.products);
          final List<ProductData> newList = data.data ?? [];
          products.addAll(newList);
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
          state = state.copyWith(
            isMoreLoading: false,
            products: products,
            hasMore: newList.length >= 10,
          );
        },
        failure: (failure) {
          _page--;
          state = state.copyWith(isMoreLoading: false);
          debugPrint('==> get category products failure: $failure');
        },
      );
    }
  }

  Future<void> updateCategoryProducts({
    int? categoryId,
    int? shopId,
    CartData? cartData,
  }) async {
    _page = 0;
    state = state.copyWith(hasMore: true);
    fetchCategoryProducts(
      categoryId: categoryId,
      shopId: shopId,
      cartData: cartData,
    );
  }
}
