import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../models/models.dart';
import '../../../../../../../repository/repository.dart';
import '../state/product_cart_count_state.dart';

class ProductCartCountNotifier extends StateNotifier<ProductCartCountState> {
  final CartsRepository _cartsRepository;
  Timer? _timer;

  ProductCartCountNotifier(this._cartsRepository)
      : super(const ProductCartCountState());

  Future<void> _saveToCart({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      await _cartsRepository.saveProductToCart(
        shopId: state.product?.shopId,
        productId: state.product?.id,
        quantity: state.product?.localCartCount,
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setProduct({ProductData? product, CartData? cartData}) {
    final int cartCount = AppHelpers.getProductCartCount(
      cartData,
      product,
    );
    if (cartCount != 0) {
      product =
          product?.copyWith(cartCount: cartCount, localCartCount: cartCount);
    }
    state = state.copyWith(product: product);
  }

  void increaseCartCount() {
    final int maxQty = state.product?.maxQty ?? 0;
    final int qty = state.product?.quantity ?? 0;
    final int localCartCount = state.product?.localCartCount ?? 0;
    if (localCartCount >= maxQty || localCartCount >= qty) {
      return;
    }
    _timer?.cancel();
    state = state.copyWith(
      product: state.product?.copyWith(localCartCount: localCartCount + 1),
    );
    _timer = Timer(
      const Duration(milliseconds: 400),
      () {
        _saveToCart();
      },
    );
  }

  void decreaseCartCount() {
    final int minQty = state.product?.minQty ?? 0;
    final int localCartCount = state.product?.localCartCount ?? 0;
    if (localCartCount <= minQty) {
      return;
    }
    _timer?.cancel();
    state = state.copyWith(
      product: state.product?.copyWith(localCartCount: localCartCount - 1),
    );
    _timer = Timer(
      const Duration(milliseconds: 400),
      () {
        _saveToCart();
      },
    );
  }
}
