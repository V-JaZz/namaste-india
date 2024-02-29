// To parse this JSON data, do
//
//     final restaurantProfileModel = restaurantProfileModelFromJson(jsonString);

import 'dart:convert';

RestaurantProfileModel restaurantProfileModelFromJson(String str) => RestaurantProfileModel.fromJson(json.decode(str));

class RestaurantProfileModel {
  RestaurantProfileModel({
    this.success,
    this.data,
  });

  final bool? success;
  final RestaurantData? data;

  factory RestaurantProfileModel.fromJson(Map<String, dynamic> json) => RestaurantProfileModel(
    success: json["success"],
    data: json["data"] == null ? null : RestaurantData.fromJson(json["data"]),
  );
}

class RestaurantData {
  RestaurantData({
    this.isActive,
    this.restaurantId,
    this.email,
    this.shortDescription,
    this.image,
    this.imageIcon,
    this.isOnline,
    this.review,
    this.deliveryDiscount,
    this.collectionDiscount,
    this.openTime,
    this.closeTime,
    this.openDay,
    this.closeDay,
    this.passcode,
    this.acceptedPostcodes,
    this.minimumOrder,
    this.deliveryRadius,
    this.deliveryTime,
    this.collectionTime,
    this.deliveryCharges,
    this.distanceDetails,
    this.allowOnlineDelivery,
    this.allowOnlinePickup,
    this.location,
    this.phoneNumber,
    this.ownerId,
    this.restEmail,
    this.timeSlots,
  });

  final bool? isActive;
  final String? restaurantId;
  final String? email;
  final String? shortDescription;
  final String? image;
  final String? imageIcon;
  final bool? isOnline;
  final int? review;
  final int? deliveryDiscount;
  final int? collectionDiscount;
  final String? openTime;
  final String? closeTime;
  final dynamic openDay;
  final dynamic closeDay;
  final List<String>? passcode;
  final List<String>? acceptedPostcodes;
  final int? minimumOrder;
  final int? deliveryRadius;
  final dynamic deliveryTime;
  final String? collectionTime;
  final int? deliveryCharges;
  final List<DistanceDetail>? distanceDetails;
  final bool? allowOnlineDelivery;
  final bool? allowOnlinePickup;
  final String? location;
  final String? phoneNumber;
  final String? ownerId;
  final String? restEmail;
  final List<TimeSlot>? timeSlots;

  factory RestaurantData.fromJson(Map<String, dynamic> json) => RestaurantData(
    isActive: json["isActive"],
    restaurantId: json["restaurantId"],
    email: json["email"],
    shortDescription: json["shortDescription"],
    image: json["image"],
    imageIcon: json["imageIcon"],
    isOnline: json["isOnline"],
    review: json["review"],
    deliveryDiscount: json["deliveryDiscount"],
    collectionDiscount: json["collectionDiscount"],
    openTime: json["openTime"],
    closeTime: json["closeTime"],
    openDay: json["openDay"],
    closeDay: json["closeDay"],
    passcode: json["passcode"] == null ? [] : List<String>.from(json["passcode"]!.map((x) => x)),
    acceptedPostcodes: json["acceptedPostcodes"] == null ? [] : List<String>.from(json["acceptedPostcodes"]!.map((x) => x)),
    minimumOrder: json["minimumOrder"],
    deliveryRadius: json["deliveryRadius"],
    deliveryTime: json["deliveryTime"],
    collectionTime: json["collectionTime"],
    deliveryCharges: json["deliveryCharges"],
    distanceDetails: json["distanceDetails"] == null ? [] : List<DistanceDetail>.from(json["distanceDetails"]!.map((x) => DistanceDetail.fromJson(x))),
    allowOnlineDelivery: json["allowOnlineDelivery"],
    allowOnlinePickup: json["allowOnlinePickup"],
    location: json["location"],
    phoneNumber: json["phoneNumber"],
    ownerId: json["ownerId"],
    restEmail: json["restEmail"],
    timeSlots: json["timeSlots"] == null ? [] : List<TimeSlot>.from(json["timeSlots"]!.map((x) => TimeSlot.fromJson(x))),
  );
}

class DistanceDetail {
  DistanceDetail({
    this.postcode,
    this.deliveryCharge,
    this.minOrder,
    this.deliveryTime,
    this.id,
  });

  final String? postcode;
  final String? deliveryCharge;
  final String? minOrder;
  final String? deliveryTime;
  final String? id;

  factory DistanceDetail.fromJson(Map<String, dynamic> json) => DistanceDetail(
    postcode: json["postcode"],
    deliveryCharge: json["deliveryCharge"],
    minOrder: json["minOrder"],
    deliveryTime: json["deliveryTime"],
    id: json["id"],
  );
}

class TableDetail {
  TableDetail({
    this.table,
    this.status,
  });

  final int? table;
  final String? status;

  factory TableDetail.fromJson(Map<String, dynamic> json) => TableDetail(
    table: json["table"],
    status: json["status"],
  );
}

class TimeSlot {
  TimeSlot({
    this.days,
    this.holidayDates,
    this.isActive,
    this.id,
    this.openTime,
    this.closeTime,
    this.restaurantId,
    this.name,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  final List<String>? days;
  final List<dynamic>? holidayDates;
  final bool? isActive;
  final String? id;
  final String? openTime;
  final String? closeTime;
  final String? restaurantId;
  final String? name;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
    days: json["days"] == null ? [] : List<String>.from(json["days"]!.map((x) => x)),
    holidayDates: json["holidayDates"] == null ? [] : List<dynamic>.from(json["holidayDates"]!.map((x) => x)),
    isActive: json["isActive"],
    id: json["_id"],
    openTime: json["openTime"],
    closeTime: json["closeTime"],
    restaurantId: json["restaurantId"],
    name: json["name"],
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );
}