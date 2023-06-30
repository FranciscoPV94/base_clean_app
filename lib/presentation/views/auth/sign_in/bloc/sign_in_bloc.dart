import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:default_app/domain/datasource/session_datasource.dart';

import '/domain/repositories/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final IAuthRepository _authRepository;
  final ISessionDatasource _sessionRepository;
  SignInBloc(
      {required IAuthRepository authRepository,
      required ISessionDatasource sessionRepository})
      : _authRepository = authRepository,
        _sessionRepository = sessionRepository,
        super(SignInInitial()) {
    on<SubmitForm>((event, emit) async {
      emit(SignInLoading());

      final loginResponse = await _authRepository.login(
        user: event.email,
        password: event.password,
      );
      if (loginResponse.isFailed) {
        return emit(
          SignInFailed(
            message: loginResponse.message ?? '',
          ),
        );
      }
      await _sessionRepository.saveToken(token: loginResponse.model!);
      emit(SignInSuccess());
    });
  }
}
