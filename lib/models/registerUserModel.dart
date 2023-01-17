// To parse this JSON data, do
//
//     final registerUser = registerUserFromJson(jsonString);

import 'dart:convert';

List<RegisterUser?>? registerUserFromJson(String str) => json.decode(str) == null ? [] : List<RegisterUser?>.from(json.decode(str)!.map((x) => RegisterUser.fromJson(x)));

String registerUserToJson(List<RegisterUser?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class RegisterUser {
  RegisterUser({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
    success: json["success"],
    data: json["data"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
    "message": message,
  };
}

class Data {
  Data({
    this.isDelete,
    this.isActive,
    this.contact,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.firstName,
    this.lastName,
    this.token,
  });

  bool? isDelete;
  bool? isActive;
  String? contact;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? email;
  String? firstName;
  String? lastName;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isDelete: json["isDelete"],
    isActive: json["isActive"],
    contact: json["contact"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "isDelete": isDelete,
    "isActive": isActive,
    "contact": contact,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "token": token,
  };
}
