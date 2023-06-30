import '../../data/models/auth_key_model.dart';

abstract class ISessionDatasource {
  Future<bool> saveToken({required AuthKeysModel token});
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<void> deleteToken();
}
