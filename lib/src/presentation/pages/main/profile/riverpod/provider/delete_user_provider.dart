import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependency_manager.dart';
import '../notifier/delete_user_notifier.dart';
import '../state/delete_user_state.dart';

final deleteUserProvider =
    StateNotifierProvider<DeleteUserNotifier, DeleteUserState>(
  (ref) => DeleteUserNotifier(userRepository),
);
