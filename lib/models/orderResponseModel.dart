// To parse this JSON data, do
//
//     final orderResponseModel = orderResponseModelFromJson(jsonString);

import 'dart:convert';

List<OrderResponseModel> orderResponseModelFromJson(String str) => List<OrderResponseModel>.from(json.decode(str).map((x) => OrderResponseModel.fromJson(x)));

String orderResponseModelToJson(List<OrderResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderResponseModel {
  OrderResponseModel({
    this.success,
    this.message,
    this.data,
    this.ownerId,
    this.orderId,
    this.orderNumber,
  });

  bool? success;
  String? message;
  String? data;
  OwnerId? ownerId;
  String? orderId;
  String? orderNumber;

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) => OrderResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"],
    ownerId: json["ownerId"] == null ? null : OwnerId.fromJson(json["ownerId"]),
    orderId: json["orderId"],
    orderNumber: json["orderNumber"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
    "ownerId": ownerId?.toJson(),
    "orderId": orderId,
    "orderNumber": orderNumber,
  };
}

class OwnerId {
  OwnerId({
    this.email,
  });

  String? email;

  factory OwnerId.fromJson(Map<String, dynamic> json) => OwnerId(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
