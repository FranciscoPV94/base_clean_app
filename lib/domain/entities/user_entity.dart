// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);

import 'dart:convert';

import '../../core/typedefs.dart';

UserEntity userEntityFromJson(String str) =>
    UserEntity.fromJson(json.decode(str) as Json);

String userEntityToJson(UserEntity data) => json.encode(data.toJson());

class UserEntity {
  final int id;
  final String? nombre;
  final String? correo;
  final String? rfc;
  final int? idProveedor;

  const UserEntity(
      {required this.id, this.nombre, this.correo, this.rfc, this.idProveedor});

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
      id: json['Id'] as int,
      nombre: json['Nombre'] as String,
      correo: json['Correo'] as String,
      rfc: json['RFC'] as String,
      idProveedor: json['IdProveedor'] as int);

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Nombre': nombre,
        'Correo': correo,
        'RFC': rfc,
        'IdProveedor': idProveedor
      };

  static const empty = UserEntity(
    id: 0,
  );

  bool get isEmpty => this == UserEntity.empty;
  bool get isNotEmpty => this != UserEntity.empty;
}
