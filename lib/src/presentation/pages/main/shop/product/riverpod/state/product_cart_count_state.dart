import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../models/models.dart';

part 'product_cart_count_state.freezed.dart';

@freezed
class ProductCartCountState with _$ProductCartCountState {
  const factory ProductCartCountState({ProductData? product}) =
      _ProductCartCountState;

  const ProductCartCountState._();
}
