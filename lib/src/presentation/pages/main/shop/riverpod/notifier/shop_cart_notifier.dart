import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../models/models.dart';
import '../../../../../../repository/repository.dart';
import '../state/shop_cart_state.dart';

class ShopCartNotifier extends StateNotifier<ShopCartState> {
  final CartsRepository _cartsRepository;

  ShopCartNotifier(this._cartsRepository) : super(const ShopCartState());

  void setShopCart(CartData? cartData) {
    state = state.copyWith(cartData: cartData);
  }

  Future<void> fetchShopCart({int? shopId, VoidCallback? afterFetched}) async {
    final response = await _cartsRepository.getUserCart(shopId: shopId);
    response.when(
      success: (data) {
        state = state.copyWith(cartData: data.data);
        afterFetched?.call();
      },
      failure: (failure) {
        debugPrint('==> get shop cart failure: $failure');
        state = state.copyWith(cartData: null);
        afterFetched?.call();
      },
    );
  }
}
