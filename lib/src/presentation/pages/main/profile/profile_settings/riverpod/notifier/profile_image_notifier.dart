import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/constants/constants.dart';
import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../repository/repository.dart';
import '../state/profile_image_state.dart';

class ProfileImageNotifier extends StateNotifier<ProfileImageState> {
  final UserRepository _userRepository;
  final SettingsRepository _settingsRepository;

  ProfileImageNotifier(this._userRepository, this._settingsRepository)
      : super(const ProfileImageState());

  Future<void> updateProfileImage({
    required String path,
    String? firstname,
  }) async {
    String? url;
    final imageResponse =
        await _settingsRepository.uploadImage(path, UploadType.users);
    imageResponse.when(
      success: (data) {
        url = data.imageData?.title;
      },
      failure: (failure) {
        debugPrint('==> upload profile image failure: $failure');
      },
    );
    if (url == null) {
      return;
    }
    final response = await _userRepository.updateProfileImage(
      imageUrl: url,
      firstName: firstname,
    );
    response.when(
      success: (data) {
        setUrl(data.data?.img);
        LocalStorage.instance.setUser(data.data);
        if (data.data?.wallet != null) {
          LocalStorage.instance.setWallet(data.data?.wallet);
        }
      },
      failure: (failure) {
        debugPrint('==> update profile image failure: $failure');
      },
    );
  }

  void changePhoto({String? path, String? firstname}) {
    state = state.copyWith(path: path, imageUrl: null);
    if (path != null) {
      updateProfileImage(path: path, firstname: firstname);
    }
  }

  void setUrl(String? url) {
    state = state.copyWith(path: null, imageUrl: url);
  }
}
