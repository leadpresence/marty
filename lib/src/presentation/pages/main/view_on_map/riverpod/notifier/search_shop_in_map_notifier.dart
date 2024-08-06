import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../repository/repository.dart';
import '../state/search_shop_in_map_state.dart';

class SearchShopInMapNotifier extends StateNotifier<SearchShopInMapState> {
  final ShopsRepository _shopsRepository;
  Timer? _timer;

  SearchShopInMapNotifier(this._shopsRepository)
      : super(const SearchShopInMapState());

  void setQuery(BuildContext context, String query) {
    if (state.shopQuery == query) {
      return;
    }
    state = state.copyWith(shopQuery: query.trim());
    if (state.shopQuery.isNotEmpty) {
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      }
      _timer = Timer(
        const Duration(milliseconds: 500),
        () {
          searchShops(
            checkYourNetwork: () {
              AppHelpers.showCheckFlash(
                context,
                AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
              );
            },
          );
        },
      );
    } else {
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      }
      _timer = Timer(
        const Duration(milliseconds: 500),
        () {
          state = state.copyWith(isSearching: false);
        },
      );
    }
  }

  Future<void> searchShops({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isSearchLoading: true, isSearching: true);
      final response =
          await _shopsRepository.searchShops(query: state.shopQuery);
      response.when(
        success: (data) {
          state = state.copyWith(
            isSearchLoading: false,
            searchedShops: data.data ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isSearchLoading: false);
          debugPrint('==> search shops failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}
