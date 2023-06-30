import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:injector/injector.dart';

import '../../domain/datasource/session_datasource.dart';
import '../../domain/repositories/auth_repository.dart';

final client = InterceptedClient.build(
  interceptors: [
    AuthorizationInterceptor(sessionRepository: Injector.appInstance.get())
  ],
  retryPolicy: ExpiredTokenRetryPolicy(
      authRepository: Injector.appInstance.get(),
      sessionRepository: Injector.appInstance.get()),
);

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 2;

  final IAuthRepository authRepository;
  final ISessionDatasource sessionRepository;

  ExpiredTokenRetryPolicy(
      {required this.authRepository, required this.sessionRepository});

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      final resp = await authRepository.refreshToken();
      if (resp.isFailed) return false;
      final success = await sessionRepository.saveToken(token: resp.model!);
      return success;
    }

    return false;
  }
}

class AuthorizationInterceptor implements InterceptorContract {
  final ISessionDatasource sessionRepository;

  AuthorizationInterceptor({required this.sessionRepository});
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      final token = await sessionRepository.getToken();
      data.headers[HttpHeaders.authorizationHeader] = 'bearer $token';
    } catch (e) {
      throw Exception('Error al poner el token');
    }

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}
