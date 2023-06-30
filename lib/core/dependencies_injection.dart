import 'package:injector/injector.dart';

import '../data/datasource/session_datasource_imp.dart';
import '../data/repositories/auth_repository_imp.dart';
import '../domain/datasource/session_datasource.dart';
import '../domain/repositories/auth_repository.dart';

void injectDependencies() {
  Injector.appInstance
      .registerSingleton<ISessionDatasource>(SessionDatasource.new);
  Injector.appInstance.registerSingleton<IAuthRepository>(AuthRepository.new);
}
