part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class CheckIfUserIsAuthenticated extends AppEvent {}

class LogoutUser extends AppEvent {}

class AuthenticatedUser extends AppEvent {}
