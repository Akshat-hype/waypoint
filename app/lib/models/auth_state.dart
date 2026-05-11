import 'user_model.dart';

class AuthState {

  final bool isLoading;

  final bool isAuthenticated;

  final UserModel? user;

  final String? token;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.token,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    UserModel? user,
    String? token,
  }) {
    return AuthState(
      isLoading:
          isLoading ?? this.isLoading,

      isAuthenticated:
          isAuthenticated ??
              this.isAuthenticated,

      user: user ?? this.user,

      token: token ?? this.token,
    );
  }
}