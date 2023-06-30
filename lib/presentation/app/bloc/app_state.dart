part of 'app_bloc.dart';

abstract class AppState {
  final String initialRoute;
  final UserEntity user;
  const AppState({required this.initialRoute, this.user = UserEntity.empty});
}

class AppLoadingState extends AppState {
  const AppLoadingState({
    super.initialRoute = SplashScreen.routeName,
  });
}

class AppUnauthenticatedUserState extends AppState {
  const AppUnauthenticatedUserState({
    super.initialRoute = SignInScreen.routeName,
  });
}

class AppAuthenticatedUserState extends AppState {
  const AppAuthenticatedUserState(
      {required super.initialRoute, required super.user});
}
