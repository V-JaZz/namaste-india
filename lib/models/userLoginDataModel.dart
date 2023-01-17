// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

// List<VerifyOtpModel> verifyOtpModelFromJson(String str) => List<VerifyOtpModel>.from(json.decode(str).map((x) => VerifyOtpModel.fromJson(x)));

class UserDataModel {
  UserDataModel({
    required this.success,
    required this.userData,
  });

  bool success;
  UserData userData;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    success: json["success"],
    userData: UserData.fromJson(json["userData"]),
  );
}

class UserData {
  UserData({
    required this.isDelete,
    required this.isActive,
    required this.contact,
    required this.createdAt,
    required this.updatedAt,
    this.email,
    this.firstName,
    this.lastName,
    this.token,
  });

  bool isDelete;
  bool isActive;
  String contact;
  DateTime createdAt;
  DateTime updatedAt;
  String? email;
  String? firstName;
  String? lastName;
  String? token;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    isDelete: json["isDelete"],
    isActive: json["isActive"],
    contact: json["contact"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    email: json["email"] ?? '',
    firstName: json["firstName"] ?? '',
    lastName: json["lastName"] ?? '',
    token: json["token"] ?? '',
  );
}
