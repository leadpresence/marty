import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../models/models.dart';

part 'shop_cart_in_product_state.freezed.dart';

@freezed
class ShopCartInProductState with _$ShopCartInProductState {
  const factory ShopCartInProductState({
    @Default(false) bool isLoading,
    CartData? cartData,
  }) = _ShopCartInProductState;

  const ShopCartInProductState._();
}
