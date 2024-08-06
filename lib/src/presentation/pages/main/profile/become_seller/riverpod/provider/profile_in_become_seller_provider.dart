import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/profile_in_become_seller_notifier.dart';
import '../state/profile_in_become_seller_state.dart';

final profileInBecomeSellerProvider = StateNotifierProvider.autoDispose<
    ProfileInBecomeSellerNotifier, ProfileInBecomeSellerState>(
  (ref) => ProfileInBecomeSellerNotifier(userRepository),
);
