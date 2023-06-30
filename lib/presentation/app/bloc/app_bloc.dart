import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/datasource/session_datasource.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../shared/loader.dart';
import '../../views/auth/sign_in/sign_in_screen.dart';
import '../../views/home/home_screen.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final ISessionDatasource _sessionRepository;
  final IAuthRepository _authRepository;

  AppBloc(
      {required ISessionDatasource sessionRepository,
      required IAuthRepository authRepository})
      : _sessionRepository = sessionRepository,
        _authRepository = authRepository,
        super(const AppLoadingState()) {
    on<CheckIfUserIsAuthenticated>((event, emit) async {
      final token = await _sessionRepository.getToken();

      if (token == null || token.isEmpty) {
        return emit(const AppUnauthenticatedUserState());
      }

      try {
        final resp = await _authRepository.getUser();
        return emit(AppAuthenticatedUserState(
            user: resp.model!, initialRoute: HomeScreen.routeName));
      } catch (e) {
        return emit(const AppUnauthenticatedUserState());
      }
    });

    on<LogoutUser>((event, emit) async {
      await _sessionRepository.deleteToken();
      return emit(const AppUnauthenticatedUserState());
    });

    on<AuthenticatedUser>((event, emit) async {
      final user = await _authRepository.getUser();
      return emit(
        AppAuthenticatedUserState(
            initialRoute: HomeScreen.routeName, user: user.model!),
      );
    });
  }
}
