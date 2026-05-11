import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';

import '../../features/auth/screens/login_screen.dart';

import '../../features/auth/screens/signup_screen.dart';

import '../../features/home/screens/home_screen.dart';

import '../../features/trips/screens/create_trip_screen.dart';

import 'route_names.dart';

final router = GoRouter(
  initialLocation: RouteNames.login,

  redirect: (context, state) {

    final container =
        ProviderScope.containerOf(
      context,
    );

    final authState =
        container.read(
      authNotifierProvider,
    );

    final isLoggedIn =
        authState.isAuthenticated;

    final isAuthRoute =
        state.fullPath ==
            RouteNames.login ||
        state.fullPath ==
            RouteNames.signup;

    if (!isLoggedIn &&
        !isAuthRoute) {
      return RouteNames.login;
    }

    if (isLoggedIn &&
        isAuthRoute) {
      return RouteNames.home;
    }

    return null;
  },

  routes: [

    GoRoute(
      path: RouteNames.login,
      builder: (context, state) =>
          const LoginScreen(),
    ),

    GoRoute(
      path: RouteNames.signup,
      builder: (context, state) =>
          const SignupScreen(),
    ),

    GoRoute(
      path: RouteNames.home,
      builder: (context, state) =>
          const HomeScreen(),
    ),

    GoRoute(
      path: RouteNames.createTrip,

      builder: (context, state) =>
        const CreateTripScreen(),
    ),
  ],
);