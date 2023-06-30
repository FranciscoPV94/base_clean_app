import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../core/app_config.dart';
import '../../core/extensions/http_interceptor_extension.dart';
import '../../core/typedefs.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_key_model.dart';
import '../models/response_model.dart';

class AuthRepository extends IAuthRepository {
  @override
  Future<ResponseModel<AuthKeysModel?>> login(
      {required String user, required String password}) async {
    try {
      // ignore: unused_local_variable
      // final passHash = sha512.convert(utf8.encode(password));

      final Map data = <String, dynamic>{
        'rfc': user,
        'password': password //passHash.toString(),
      };

      final headers = <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json'
      };

      final resp = await http.post(Uri.parse('$urlService/Login'),
          body: json.encode(data),
          headers: headers,
          encoding: Encoding.getByName('utf-8'));

      final decodedata = json.decode(resp.body) as Json;

      if (decodedata['Success'] as bool) {
        final rawCookie = resp.headers['set-cookie'];
        final index = rawCookie!.indexOf(';');
        final cookies =
            (index == -1) ? rawCookie : rawCookie.substring(0, index);

        final userData = decodedata['Model'] as Json;

        return ResponseModel<AuthKeysModel?>(
            message: decodedata['Message'] as String,
            success: decodedata['Success'] as bool,
            model: AuthKeysModel(
                token: userData['Token'] as String, refreshToken: cookies));
      } else {
        return ResponseModel<AuthKeysModel?>(
          message: decodedata['Message'] as String,
          success: decodedata['Success'] as bool,
        );
      }
    } catch (e) {
      return ResponseModel<AuthKeysModel?>(
        message: e.toString(),
        success: false,
      );
    }
  }

  @override
  Future<ResponseModel<UserEntity>> getUser() async {
    try {
      final resp = await client.get(Uri.parse('$urlService/GetMe'), headers: {
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
      });
      final decodedata = json.decode(resp.body) as Map<String, dynamic>;
      if (decodedata['Success'] == true) {
        final result = ResponseModel(
            message: decodedata['Message'] as String?,
            success: decodedata['Success'] as bool,
            model: UserEntity.fromJson(
                decodedata['Model'] as Map<String, dynamic>));

        return result;
      }

      return ResponseModel(
          message: decodedata['Message'] as String,
          success: decodedata['Success'] as bool);
    } catch (e) {
      return ResponseModel(message: e.toString(), success: false);
    }
  }

  @override
  Future<ResponseModel<AuthKeysModel>> refreshToken() async {
    try {
      final cookie = await getRefreshToken();
      final resp = await http.post(
        Uri.parse('$urlService/RefreshToken'),
        headers: {HttpHeaders.cookieHeader: cookie!},
      );

      if (resp.statusCode != 401) {
        final rawCookie = resp.headers['set-cookie'];
        final index = rawCookie!.indexOf(';');
        final cookies =
            (index == -1) ? rawCookie : rawCookie.substring(0, index);

        return ResponseModel(
            success: true,
            message: 'ok',
            model: AuthKeysModel(refreshToken: cookies, token: resp.body));
      } else {
        return ResponseModel(success: false, message: resp.body);
      }
    } catch (e) {
      log(e.toString());
      return ResponseModel(success: false, message: e.toString());
    }
  }
}
