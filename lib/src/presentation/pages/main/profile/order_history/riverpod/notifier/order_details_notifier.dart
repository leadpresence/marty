import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../repository/repository.dart';
import '../state/order_details_state.dart';

class OrderDetailsNotifier extends StateNotifier<OrderDetailsState> {
  final OrdersRepository _ordersRepository;

  OrderDetailsNotifier(this._ordersRepository)
      : super(const OrderDetailsState());

  Future<void> fetchOrderDetails({
    VoidCallback? checkYourNetwork,
    int? orderId,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response =
          await _ordersRepository.getOrderDetails(orderId: orderId);
      response.when(
        success: (data) {
          state = state.copyWith(isLoading: false, orderData: data.data);
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get order details failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}
