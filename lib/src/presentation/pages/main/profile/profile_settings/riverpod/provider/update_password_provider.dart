import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/update_password_notifier.dart';
import '../state/update_password_state.dart';

final updatePasswordProvider = StateNotifierProvider.autoDispose<
    UpdatePasswordNotifier, UpdatePasswordState>(
  (ref) => UpdatePasswordNotifier(userRepository),
);
