import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart' as location;

import '../../../../../../repository/repository.dart';
import '../state/shops_in_map_state.dart';
import 'shop_markers_notifier.dart';

class ShopsInMapNotifier extends StateNotifier<ShopsInMapState> {
  final ShopsRepository _shopsRepository;
  location.LocationData? _myLocationData;

  ShopsInMapNotifier(this._shopsRepository) : super(const ShopsInMapState());

  Future<void> fetchPickupShops({
    ShopMarkersNotifier? shopMarkersNotifier,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _shopsRepository.getPickupShops();
    response.when(
      success: (data) {
        state = state.copyWith(shops: data.data ?? [], isLoading: false);
        shopMarkersNotifier?.fetchMarkers(data.data);
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get pickup shops failure: $failure');
      },
    );
  }

  Future<void> fetchNewShops({
    ShopMarkersNotifier? shopMarkersNotifier,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _shopsRepository.getNewShops();
    response.when(
      success: (data) {
        state = state.copyWith(shops: data.data ?? [], isLoading: false);
        shopMarkersNotifier?.fetchMarkers(data.data);
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get new shops failure: $failure');
      },
    );
  }

  Future<void> fetchWork247Shops({
    ShopMarkersNotifier? shopMarkersNotifier,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _shopsRepository.getWork247Shops();
    response.when(
      success: (data) {
        state = state.copyWith(shops: data.data ?? [], isLoading: false);
        shopMarkersNotifier?.fetchMarkers(data.data);
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get work 24/7 shops failure: $failure');
      },
    );
  }

  Future<void> findMyLocation() async {
    final locationInstance = location.Location();
    bool serviceEnabled;
    location.PermissionStatus permissionGranted;
    serviceEnabled = await locationInstance.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationInstance.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await locationInstance.hasPermission();
    if (permissionGranted == location.PermissionStatus.denied) {
      permissionGranted = await locationInstance.requestPermission();
      if (permissionGranted != location.PermissionStatus.granted) {
        return;
      }
    }
    try {
      _myLocationData = await locationInstance.getLocation();
    } on Exception {
      _myLocationData = null;
    }
  }

  Future<void> fetchNearbyShops({
    ShopMarkersNotifier? shopMarkersNotifier,
  }) async {
    await findMyLocation();
    state = state.copyWith(isLoading: true);
    final response = await _shopsRepository.getNearbyShops(
      latitude: _myLocationData?.latitude,
      longitude: _myLocationData?.longitude,
    );
    response.when(
      success: (data) {
        state = state.copyWith(shops: data.data ?? [], isLoading: false);
        shopMarkersNotifier?.fetchMarkers(data.data);
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get nearby failure: $failure');
      },
    );
  }

  Future<void> fetchOpenNowShops({
    ShopMarkersNotifier? shopMarkersNotifier,
  }) async {
    findMyLocation();
    state = state.copyWith(isLoading: true);
    final response = await _shopsRepository.getOpenNowShops();
    response.when(
      success: (data) {
        state = state.copyWith(shops: data.data ?? [], isLoading: false);
        shopMarkersNotifier?.fetchMarkers(data.data);
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get open now shops failure: $failure');
      },
    );
  }
}
