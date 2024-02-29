// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:namastey_india/models/homeMenuModel.dart';

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.deliveryType,
    this.itemDetails,
    this.paymentMode,
    this.orderTime,
    this.tip,
    this.subTotal,
    this.discount,
    this.totalAmount,
    this.deliveryCharge,
    this.note,
    this.address,
    this.contact,
    this.houseNumber,
    this.street,
    this.city,
    this.postcode,
    this.restaurantId,
    this.deliveryAddress,
  });

  String? deliveryType;
  List<ItemDetail>? itemDetails;
  String? paymentMode;
  String? orderTime;
  int? tip;
  String? subTotal;
  String? discount;
  String? totalAmount;
  int? deliveryCharge;
  String? note;
  String? address;
  String? contact;
  String? houseNumber;
  String? street;
  String? city;
  String? postcode;
  String? restaurantId;
  String? deliveryAddress;

  Map<String, dynamic> toJson() => {
    "deliveryType": deliveryType,
    "itemDetails": itemDetails == null ? [] : List<dynamic>.from(itemDetails!.map((x) => x.toJson())),
    "paymentMode": paymentMode,
    "orderTime": orderTime,
    "tip": tip,
    "subTotal": subTotal,
    "discount": discount,
    "totalAmount": totalAmount,
    "deliveryCharge": deliveryCharge,
    "note": note,
    "address": address,
    "contact": contact,
    "houseNumber": houseNumber,
    "street": street,
    "city": city,
    "postcode": postcode,
    "restaurantId": restaurantId,
    "deliveryAddress": deliveryAddress,
  };
}

class ItemDetail {
  ItemDetail({
    this.id,
    this.name,
    this.option,
    this.price,
    this.note,
    this.toppings,
    this.discount,
    this.catDiscount,
    this.overallDiscount,
    this.excludeDiscount,
    this.variant,
    this.variantPrice,
    this.subVariant,
    this.subVariantPrice,
    this.quantity,
  });

  String? id;
  String? name;
  String? option;
  double? price;
  String? note;
  List<Topping>? toppings;
  int? discount;
  int? catDiscount;
  int? overallDiscount;
  bool? excludeDiscount;
  String? variant;
  double? variantPrice;
  String? subVariant;
  int? subVariantPrice;
  int? quantity;

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "option": option,
    "price": price,
    "note": note,
    "toppings": toppings == null ? [] : List<dynamic>.from(toppings!.map((x) => x.toJson())),
    "discount": discount,
    "catDiscount": catDiscount,
    "overallDiscount": overallDiscount,
    "excludeDiscount": excludeDiscount,
    "variant": variant,
    "variantPrice": variantPrice,
    "subVariant": subVariant,
    "subVariantPrice": subVariantPrice,
    "quantity": quantity,
  };
}
