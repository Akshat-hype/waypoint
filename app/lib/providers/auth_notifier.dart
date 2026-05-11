import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_state.dart';

import '../models/user_model.dart';

class AuthNotifier
    extends StateNotifier<AuthState> {

  AuthNotifier()
      : super(AuthState());

  Future<void> saveAuthData({
    required String token,
    required UserModel user,
  }) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      "token",
      token,
    );

    await prefs.setString(
      "user",
      jsonEncode({
        "id": user.id,
        "name": user.name,
        "email": user.email,
        "profile_image":
            user.profileImage,
      }),
    );

    state = state.copyWith(
      isAuthenticated: true,
      token: token,
      user: user,
    );
  }

  Future<void> loadUser() async {

    final prefs =
        await SharedPreferences.getInstance();

    final token =
        prefs.getString("token");

    final userData =
        prefs.getString("user");

    if (token != null &&
        userData != null) {

      final decoded =
          jsonDecode(userData);

      final user =
          UserModel.fromJson(decoded);

      state = state.copyWith(
        isAuthenticated: true,
        token: token,
        user: user,
      );
    }
  }

  Future<void> logout() async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.clear();

    state = AuthState();
  }
}