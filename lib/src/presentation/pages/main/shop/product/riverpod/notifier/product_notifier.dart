import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../models/models.dart';
import '../../../../../../../repository/repository.dart';
import '../state/product_state.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRepository _productsRepository;
  final CartsRepository _cartsRepository;
  Timer? _timer;

  ProductNotifier(this._productsRepository, this._cartsRepository)
      : super(const ProductState());

  void updateProductCartCount({CartData? cartData}) {
    final int localCartCount =
        AppHelpers.getProductCartCount(cartData, state.productData);
    state = state.copyWith(
      productData: state.productData?.copyWith(localCartCount: localCartCount),
    );
  }

  Future<void> _saveToCart({Function(CartData?)? onCartUpdate}) async {
    final result = await _cartsRepository.saveProductToCart(
      shopId: state.productData?.shopId,
      productId: state.productData?.id,
      quantity: state.productData?.localCartCount,
    );
    result.when(
      success: (data) {
        if (onCartUpdate != null) {
          onCartUpdate(data.data);
        }
      },
      failure: (failure) {
        debugPrint('===> save to cart failure $failure');
      },
    );
  }

  void increaseCartCount({Function(CartData?)? onCartUpdate}) {
    final int maxQty = state.productData?.maxQty ?? 0;
    final int minQty = state.productData?.minQty ?? 0;
    final int qty = state.productData?.quantity ?? 0;
    final int localCartCount = state.productData?.localCartCount ?? 0;
    if (localCartCount >= maxQty || localCartCount >= qty) {
      return;
    }
    _timer?.cancel();
    state = state.copyWith(
      productData: state.productData?.copyWith(
        localCartCount: localCartCount < 1 ? minQty : (localCartCount + 1),
      ),
    );
    _timer = Timer(
      const Duration(milliseconds: 400),
      () {
        _saveToCart(onCartUpdate: onCartUpdate);
      },
    );
  }

  void decreaseCartCount({Function(CartData?)? onCartUpdate}) {
    final int minQty = state.productData?.minQty ?? 0;
    final int localCartCount = state.productData?.localCartCount ?? 0;
    if (localCartCount <= minQty) {
      return;
    }
    _timer?.cancel();
    state = state.copyWith(
      productData:
          state.productData?.copyWith(localCartCount: localCartCount - 1),
    );
    _timer = Timer(
      const Duration(milliseconds: 400),
      () {
        _saveToCart(onCartUpdate: onCartUpdate);
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

  Future<void> fetchProductDetails({
    String? uuid,
    VoidCallback? checkYourNetwork,
    VoidCallback? fetchingFailed,
    int? shopId,
    CartData? cartData,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _productsRepository.getProductDetails(uuid: uuid);
      response.when(
        success: (data) {
          ProductData? product = data.data;
          final int cartCount =
              AppHelpers.getProductCartCount(cartData, product);
          if (cartCount != 0) {
            product = product?.copyWith(
              cartCount: cartCount,
              localCartCount: cartCount,
            );
          }
          state = state.copyWith(isLoading: false, productData: product);
          final List<LocalProductData> products =
              LocalStorage.instance.getViewedProductsList();
          bool alreadyViewed = false;
          int indexViewed = 0;
          for (int i = 0; i < products.length; i++) {
            if (products[i].productId == product?.id) {
              alreadyViewed = true;
              indexViewed = i;
            }
          }
          if (alreadyViewed) {
            products.removeAt(indexViewed);
          }
          products.insert(
            0,
            LocalProductData(productId: product?.id ?? 0, shopId: shopId),
          );
          final setList = products.toSet().toList();
          final subList =
              setList.length > 16 ? setList.sublist(0, 16) : setList;
          LocalStorage.instance.setViewedProductsList(subList);
        },
        failure: (failure) {
          fetchingFailed?.call();
          state = state.copyWith(isLoading: false);
          debugPrint('==> get product details failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}
