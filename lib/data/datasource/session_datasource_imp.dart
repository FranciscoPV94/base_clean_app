import 'dart:convert';
import 'dart:developer';

import 'package:default_app/data/models/auth_key_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/typedefs.dart';
import '../../domain/datasource/session_datasource.dart';

class SessionDatasource extends ISessionDatasource {
  final _tokenKey = 'TOKEN';
  final _storage = const FlutterSecureStorage();

  @override
  Future<bool> saveToken({required AuthKeysModel token}) async {
    try {
      log(token.toJson().toString());
      final encodedUser = json.encode(token);
      await _storage.write(key: _tokenKey, value: encodedUser);
      return true;
    } catch (e) {
      log('🤡  $e');
      log('😭 Error en repo SessionSecureStorageRepository método [saveToken]');
      return false;
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: _tokenKey);
    } catch (e) {
      log('🤡  $e');
      log('😭 Error en repo SessionSecureStorageRepository método [deleteToken]');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      final userModelStr = await _storage.read(key: _tokenKey);
      if (userModelStr == null || userModelStr == '') return null;
      final authModelMap = json.decode(userModelStr) as Json;
      return AuthKeysModel.fromJson(authModelMap).token;
    } catch (e) {
      log('🤡  $e');
      log('😭 Error en repo SessionSecureStorageRepository método [getToken]');
      return null;
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      final userModelStr = await _storage.read(key: _tokenKey);
      if (userModelStr == null || userModelStr == '') throw Exception();
      final authModelMap = json.decode(userModelStr) as Json;
      return AuthKeysModel.fromJson(authModelMap).refreshToken;
    } catch (e) {
      log('🤡  $e');
      log('😭 Error en repo SessionSecureStorageRepository método [getRefreshToken]');
      return null;
    }
  }
}
