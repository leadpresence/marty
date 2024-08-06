import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/constants/constants.dart';
import '../../../../../../../../core/utils/utils.dart';
import '../../../../../../../../repository/repository.dart';
import '../state/search_brand_state.dart';

class SearchBrandNotifier extends StateNotifier<SearchBrandState> {
  final CatalogRepository _brandsRepository;
  Timer? _timer;

  SearchBrandNotifier(this._brandsRepository) : super(const SearchBrandState());

  void setQuery(BuildContext context, String query) {
    if (state.query == query) {
      return;
    }
    state = state.copyWith(query: query.trim());
    if (state.query.isNotEmpty) {
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      }
      _timer = Timer(
        const Duration(milliseconds: 500),
        () {
          searchBrands(
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

  Future<void> searchBrands({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isSearchLoading: true, isSearching: true);
      final response =
          await _brandsRepository.getBrandsPaginate(query: state.query);
      response.when(
        success: (data) {
          state = state.copyWith(
            isSearchLoading: false,
            searchedBrands: data.data ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isSearchLoading: false);
          debugPrint('==> search brands failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}
