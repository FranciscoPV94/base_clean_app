import 'dart:convert';

import '../../core/typedefs.dart';

AuthKeysModel authKeysModelFromJson(String str) =>
    AuthKeysModel.fromJson(json.decode(str) as Json);

String authKeysModelToJson(AuthKeysModel data) => json.encode(data.toJson());

class AuthKeysModel {
  final String refreshToken;
  final String token;

  AuthKeysModel({required this.refreshToken, required this.token});

  factory AuthKeysModel.fromJson(Json json) => AuthKeysModel(
        token: json['token'] as String,
        refreshToken: json['refreshToken'] as String,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'refreshToken': refreshToken,
      };
}
