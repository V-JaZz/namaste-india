// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.success,
    this.userData,
  });

  bool? success;
  UserData? userData;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    success: json["success"],
    userData: json["userData"] == null ? null : UserData.fromJson(json["userData"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "userData": userData?.toJson(),
  };
}

class UserData {
  UserData({
    this.isDelete,
    this.isActive,
    this.contact,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.firstName,
    this.lastName,
    this.address,
    this.city,
    this.houseNumber,
    this.postcode,
    this.street,
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
  String? address;
  String? city;
  String? houseNumber;
  String? postcode;
  String? street;
  String? token;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    isDelete: json["isDelete"],
    isActive: json["isActive"],
    contact: json["contact"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    address: json["address"],
    city: json["city"],
    houseNumber: json["houseNumber"],
    postcode: json["postcode"],
    street: json["street"],
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
    "address": address,
    "city": city,
    "houseNumber": houseNumber,
    "postcode": postcode,
    "street": street,
    "token": token,
  };
}
