import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../repository/repository.dart';
import '../state/wallet_histories_state.dart';

class WalletHistoriesNotifier extends StateNotifier<WalletHistoriesState> {
  final UserRepository _userRepository;
  int _page = 0;

  WalletHistoriesNotifier(this._userRepository)
      : super(const WalletHistoriesState());

  Future<void> fetchWalletHistories({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _userRepository.getWalletHistories(page: ++_page);
      response.when(
        success: (data) {
          state = state.copyWith(wallets: data.data ?? [], isLoading: false);
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get wallet histories failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}
