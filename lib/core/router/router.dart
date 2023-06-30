import 'dart:async';

import 'package:default_app/presentation/shared/loader.dart';
import 'package:default_app/presentation/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/views/auth/sign_in/sign_in_screen.dart';
import '../../presentation/views/auth/sign_up/sign_up_screen.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final routes = [
  GoRoute(
      path: SplashScreen.routeName,
      name: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen()),
  GoRoute(
    path: SignInScreen.routeName,
    name: SignInScreen.routeName,
    builder: (context, state) => const SignInScreen(),
  ),
  GoRoute(
      path: SignUpScreen.routeName,
      name: SignUpScreen.routeName,
      builder: (context, state) => const SignUpScreen()),
  GoRoute(
      path: HomeScreen.routeName,
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen()),
];
