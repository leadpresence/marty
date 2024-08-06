import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

import '../../../../../../../core/constants/constants.dart';
import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../repository/repository.dart';
import '../state/become_seller_state.dart';

class BecomeSellerNotifier extends StateNotifier<BecomeSellerState> {
  final SettingsRepository _settingsRepository;
  final ShopsRepository _shopsRepository;

  BecomeSellerNotifier(this._settingsRepository, this._shopsRepository)
      : super(BecomeSellerState(addressController: TextEditingController()));

  Future<void> createShop(
    BuildContext context,
    LatLng? latLng, {
    VoidCallback? checkYourNetwork,
    VoidCallback? fetchProfileDetails,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final double? tax = double.tryParse(state.tax);
      if (tax == null) {
        if (mounted) {
          AppHelpers.showCheckFlash(
            context,
            AppHelpers.getTranslation(TrKeys.taxShouldBeANumber),
          );
        }
        state = state.copyWith(isLoading: false);
        return;
      }
      final double? deliveryRange = double.tryParse(state.deliveryRange);
      if (deliveryRange == null) {
        if (mounted) {
          AppHelpers.showCheckFlash(
            context,
            AppHelpers.getTranslation(TrKeys.deliveryRangeShouldBeANumber),
          );
        }
        state = state.copyWith(isLoading: false);
        return;
      }
      final double? minAmount = double.tryParse(state.minAmount);
      if (minAmount == null) {
        if (mounted) {
          AppHelpers.showCheckFlash(
            context,
            AppHelpers.getTranslation(TrKeys.minimumAmountShouldBeANumber),
          );
        }
        state = state.copyWith(isLoading: false);
        return;
      }
      String? logoImage;
      String? backgroundImage;
      final logoResponse = await _settingsRepository.uploadImage(
        state.logoPath,
        UploadType.shopsLogo,
      );
      logoResponse.when(
        success: (data) {
          logoImage = data.imageData?.title;
        },
        failure: (failure) {
          debugPrint('===> upload logo image failure: $failure');
        },
      );
      final backgroundResponse = await _settingsRepository.uploadImage(
        state.backgroundPath,
        UploadType.shopsBack,
      );
      backgroundResponse.when(
        success: (data) {
          backgroundImage = data.imageData?.title;
        },
        failure: (failure) {
          debugPrint('===> upload background image failure: $failure');
        },
      );
      final response = await _shopsRepository.createShop(
        tax: tax,
        deliveryRange: deliveryRange,
        latitude: latLng?.latitude ??
            (AppHelpers.getInitialLatitude() ?? AppConstants.demoLatitude),
        longitude: latLng?.longitude ??
            (AppHelpers.getInitialLongitude() ?? AppConstants.demoLongitude),
        phone: state.phone,
        openTime: DateFormat.Hm().format(state.openTime!),
        closeTime: DateFormat.Hm().format(state.closeTime!),
        name: state.name,
        description: state.description,
        minPrice: minAmount,
        address: state.addressController!.text,
        logoImage: logoImage,
        backgroundImage: backgroundImage,
      );
      response.when(
        success: (data) {
          state = state.copyWith(isLoading: false);
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> create shop failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> fetchLocationName(BuildContext context, LatLng? latLng) async {
    try {
      final Place place = await Nominatim.reverseSearch(
        lat: latLng?.latitude ??
            (AppHelpers.getInitialLatitude() ?? AppConstants.demoLatitude),
        lon: latLng?.longitude ??
            (AppHelpers.getInitialLongitude() ?? AppConstants.demoLongitude),
        addressDetails: true,
        extraTags: true,
        nameDetails: true,
      );
      state.addressController?.text = place.displayName;
    } catch (e) {
      state.addressController?.text = '';
    }
  }

  void setDeliveryRange(String range) {
    state = state.copyWith(deliveryRange: range);
  }

  void setTax(String tax) {
    state = state.copyWith(tax: tax);
  }

  void setMinAmount(String amount) {
    state = state.copyWith(minAmount: amount);
  }

  void setCloseTime(DateTime time) {
    state = state.copyWith(closeTime: time);
  }

  void setOpenTime(DateTime time) {
    state = state.copyWith(openTime: time);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void setPhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setLogo(String path) {
    state = state.copyWith(logoPath: path);
  }

  void setBackground(String path) {
    state = state.copyWith(backgroundPath: path);
  }
}
