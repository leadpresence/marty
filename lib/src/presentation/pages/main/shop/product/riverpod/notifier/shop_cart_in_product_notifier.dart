import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../repository/repository.dart';
import '../state/shop_cart_in_product_state.dart';

class ShopCartInProductNotifier extends StateNotifier<ShopCartInProductState> {
  final CartsRepository _cartsRepository;

  ShopCartInProductNotifier(this._cartsRepository)
      : super(const ShopCartInProductState());

  Future<void> fetchShopCart({
    int? shopId,
    VoidCallback? checkYourNetwork,
    VoidCallback? afterFetched,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _cartsRepository.getUserCart(shopId: shopId);
      response.when(
        success: (data) {
          state = state.copyWith(cartData: data.data, isLoading: false);
          afterFetched?.call();
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          afterFetched?.call();
          debugPrint('==> get shop cart failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}
