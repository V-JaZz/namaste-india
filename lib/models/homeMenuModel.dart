// To parse this JSON data, do
//
//     final homeMenuModel = homeMenuModelFromJson(jsonString);

import 'dart:convert';

HomeMenuModel homeMenuModelFromJson(String str) => HomeMenuModel.fromJson(json.decode(str));

class HomeMenuModel {
  HomeMenuModel({
    this.success,
    this.data,
  });

  bool? success;
  List<Data>? data;

  factory HomeMenuModel.fromJson(Map<String, dynamic> json) => HomeMenuModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
  );
}

class Data {
  Data({
    this.id,
    this.name,
    this.items,
    this.description,
    this.position,
    this.discount,
    this.excludeDiscount,
    this.imageName,
  });

  String? id;
  String? name;
  List<Item>? items;
  String? description;
  int? position;
  int? discount;
  bool? excludeDiscount;
  String? imageName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    name: json["name"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    description: json["description"],
    position: json["position"],
    discount: json["discount"],
    excludeDiscount: json["excludeDiscount"],
    imageName: json["imageName"],
  );
}

class Item {
  Item({
    this.id,
    this.options,
    this.variants,
    this.discount,
    this.description,
    this.excludeDiscount,
    this.imageName,
    this.name,
    this.category,
    this.price,
    this.allergies,
  });

  String? id;
  List<Option>? options;
  List<dynamic>? variants;
  int? discount;
  String? description;
  bool? excludeDiscount;
  String? imageName;
  String? name;
  Category? category;
  double? price;
  List<Allergy>? allergies;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["_id"],
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
    discount: json["discount"],
    description: json["description"],
    excludeDiscount: json["excludeDiscount"],
    imageName: json["imageName"],
    name: json["name"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    price: json["price"]?.toDouble(),
    allergies: json["allergies"] == null ? [] : List<Allergy>.from(json["allergies"]!.map((x) => Allergy.fromJson(x))),
  );
}

class Allergy {
  Allergy({
    this.id,
    this.description,
    this.createdOn,
    this.isDeleted,
    this.restaurantId,
    this.name,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? description;
  DateTime? createdOn;
  bool? isDeleted;
  String? restaurantId;
  String? name;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Allergy.fromJson(Map<String, dynamic> json) => Allergy(
    id: json["_id"],
    description: json["description"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    isDeleted: json["isDeleted"],
    restaurantId: json["restaurantId"],
    name: json["name"],
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );
}

class Category {
  Category({
    this.id,
    this.name,
    this.isActive,
    this.description,
    this.discount,
    this.excludeDiscount,
    this.position,
    this.imageName,
  });

  String? id;
  String? name;
  bool? isActive;
  String? description;
  int? discount;
  bool? excludeDiscount;
  int? position;
  String? imageName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
    isActive: json["isActive"],
    description: json["description"],
    discount: json["discount"],
    excludeDiscount: json["excludeDiscount"],
    position: json["position"],
    imageName: json["imageName"],
  );
}

class Option {
  Option({
    this.toppingGroup,
    this.minToppings,
    this.maxToppings,
    this.createdOn,
    this.restaurantId,
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.price,
    this.toppings,
  });

  String? toppingGroup;
  int? minToppings;
  int? maxToppings;
  DateTime? createdOn;
  String? restaurantId;
  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? price;
  List<Topping>? toppings;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    toppingGroup: json["toppingGroup"],
    minToppings: json["minToppings"],
    maxToppings: json["maxToppings"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    restaurantId: json["restaurantId"],
    id: json["_id"],
    name: json["name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    price: json["price"],
    toppings: json["toppings"] == null ? [] : List<Topping>.from(json["toppings"]!.map((x) => Topping.fromJson(x))),
  );
}

class Topping {
  Topping({
    this.id,
    this.createdOn,
    this.isDeleted,
    this.restaurantId,
    this.name,
    this.price,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  DateTime? createdOn;
  bool? isDeleted;
  String? restaurantId;
  String? name;
  double? price;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
    id: json["_id"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    isDeleted: json["isDeleted"],
    restaurantId: json["restaurantId"],
    name: json["name"],
    price: json["price"]?.toDouble(),
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdOn": createdOn?.toIso8601String(),
    "isDeleted": isDeleted,
    "restaurantId": restaurantId,
    "name": name,
    "price": price,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
