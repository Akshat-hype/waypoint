import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth_state.dart';

import '../features/auth/services/auth_service.dart';

import 'auth_notifier.dart';

final authServiceProvider =
    Provider<AuthService>((ref) {
  return AuthService();
});

final authNotifierProvider =
    StateNotifierProvider<
        AuthNotifier,
        AuthState>((ref) {
  return AuthNotifier();
});