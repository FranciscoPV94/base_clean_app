import 'package:default_app/core/token_facade.dart';

import '../../data/models/auth_key_model.dart';
import '../entities/user_entity.dart';
import '/data/models/response_model.dart';

abstract class IAuthRepository extends TokenFacade {
  Future<ResponseModel<AuthKeysModel?>> login({
    required String user,
    required String password,
  });

  Future<ResponseModel<AuthKeysModel>> refreshToken();

  Future<ResponseModel<UserEntity>> getUser();
}
