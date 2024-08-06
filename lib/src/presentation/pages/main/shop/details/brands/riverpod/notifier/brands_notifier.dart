import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/constants/constants.dart';
import '../../../../../../../../core/utils/utils.dart';
import '../../../../../../../../models/models.dart';
import '../../../../../../../../repository/repository.dart';
import '../state/brands_state.dart';

class BrandsNotifier extends StateNotifier<BrandsState> {
  final CatalogRepository _brandsRepository;
  int _page = 0;

  BrandsNotifier(this._brandsRepository) : super(const BrandsState());

  Future<void> fetchBrands({VoidCallback? checkYourNetwork}) async {
    if (!state.hasMore) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (_page == 0) {
        state = state.copyWith(isLoading: true);
        final response =
            await _brandsRepository.getBrandsPaginate(page: ++_page);
        response.when(
          success: (data) {
            state = state.copyWith(
              isLoading: false,
              brands: data.data ?? [],
              hasMore: (data.data ?? []).length >= 18,
            );
          },
          failure: (failure) {
            _page--;
            state = state.copyWith(isLoading: false, hasMore: false);
            debugPrint('==> get shop categories failure: $failure');
          },
        );
      } else {
        state = state.copyWith(isMoreLoading: true);
        final response =
            await _brandsRepository.getBrandsPaginate(page: ++_page);
        response.when(
          success: (data) {
            final List<BrandData> newList = List.from(state.brands);
            newList.addAll(data.data ?? []);
            state = state.copyWith(
              isMoreLoading: false,
              brands: newList,
              hasMore: (data.data ?? []).length >= 18,
            );
          },
          failure: (failure) {
            _page--;
            state = state.copyWith(isMoreLoading: false);
            debugPrint('==> get brands failure: $failure');
          },
        );
      }
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> updateBrands(BuildContext context) async {
    _page = 0;
    state = state.copyWith(hasMore: true);
    fetchBrands(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }
}
