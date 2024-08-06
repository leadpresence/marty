import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'become_seller_state.freezed.dart';

@freezed
class BecomeSellerState with _$BecomeSellerState {
  const factory BecomeSellerState({
    @Default('') String name,
    @Default('') String phone,
    @Default('') String description,
    @Default('') String minAmount,
    @Default('') String tax,
    @Default('') String deliveryRange,
    @Default('') String logoPath,
    @Default('') String backgroundPath,
    @Default(false) bool isLoading,
    DateTime? openTime,
    DateTime? closeTime,
    TextEditingController? addressController,
  }) = _BecomeSellerState;

  const BecomeSellerState._();
}
