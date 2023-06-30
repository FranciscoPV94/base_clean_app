import 'dart:convert';

import 'package:default_app/core/typedefs.dart';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel<dynamic>.fromJson(json.decode(str) as Json);
String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel<T> {
  ResponseModel(
      {required this.success,
      required this.message,
      this.model,
      this.statusCode = 200});

  factory ResponseModel.fromJson(Json json) => ResponseModel(
      success: json['Success'] as bool,
      message: json['Message'] as String,
      model: json['Model'] as T);

  bool success;
  String? message;
  T? model;
  int? statusCode;

  bool get isFailed => !success;
  bool get unauthorized => statusCode == 401;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'Success': success, 'Message': message, 'Model': model};
}
