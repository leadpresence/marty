import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/constants/constants.dart';
import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../models/models.dart';
import '../../../../../../../repository/repository.dart';
import '../state/coupon_products_state.dart';

class CouponProductsNotifier extends StateNotifier<CouponProductsState> {
  final ProductsRepository _productsRepository;
  int _couponProductsPage = 0;

  CouponProductsNotifier(this._productsRepository)
      : super(const CouponProductsState());

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

  Future<void> fetchCouponProducts({
    int? shopId,
    VoidCallback? checkYourNetwork,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _productsRepository.getDiscountProducts(
        shopId: shopId,
        page: ++_couponProductsPage,
      );
      response.when(
        success: (data) {
          state = state.copyWith(
            isLoading: false,
            couponProducts: data.data ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get coupon products failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> updateCouponProducts(
    BuildContext context, {
    int? shopId,
  }) async {
    _couponProductsPage = 0;
    fetchCouponProducts(
      shopId: shopId,
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }
}
