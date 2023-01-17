class homemodelmenu {
  bool? success;
  List<Data>? data;

  homemodelmenu({ this.success, this.data});

  homemodelmenu.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class  Data {
  String? sId;
  String? name;
  List<Items>? items;
  Null? description;
  int? position;
  int? discount;
  bool? excludeDiscount;
  String? imageName;

  Data(
      {
        this.sId,
        this.name,
        this.items,
        this.description,
        this.position,
        this.discount,
        this.excludeDiscount,
        this.imageName});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
    description = json['description'];
    position = json['position'];
    discount = json['discount'];
    excludeDiscount = json['excludeDiscount'];
    imageName = json['imageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    data['position'] = position;
    data['discount'] = discount;
    data['excludeDiscount'] = excludeDiscount;
    data['imageName'] = imageName;
    return data;
  }
}

class Items {
  String? sId;
  List<Null>? options;
  List<Null>? variants;
  int? discount;
  String? description;
  bool? excludeDiscount;
  String? imageName;
  String? name;
  Category? category;
  String? price;
  List<Allergies>? allergies;

  Items(
      {
        this.sId,
        this.options,
        this.variants,
        this.discount,
        this.description,
        this.excludeDiscount,
        this.imageName,
        this.name,
        this.category,
        this.price,
        this.allergies});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['options'] != null) {
      options = <Null>[];
      json['options'].forEach((v) {
        //options?.add(new Null!.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Null>[];
      json['variants'].forEach((v) {
        //variants!.add(new Null.fromJson(v));
      });
    }
    discount = json['discount'];
    description = json['description'];
    excludeDiscount = json['excludeDiscount'];
    imageName = json['imageName'];
    name = json['name'];
    category = (json['category'] != null
        ? Category.fromJson(json['category'])
        : null)!;
    price = json['price'].toString();
    if (json['allergies'] != null) {
      allergies = <Allergies>[];
      json['allergies'].forEach((v) {
        allergies?.add(Allergies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    if (options != null) {
      //data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (variants != null) {
      //data['variants'] = this.variants.map((v) => v!.toJson()).toList();
    }
    data['discount'] = discount;
    data['description'] = description;
    data['excludeDiscount'] = excludeDiscount;
    data['imageName'] = imageName;
    data['name'] = name;
    if (category != null) {
      data['category'] = category?.toJson();
    }
    data['price'] = price;
    if (allergies != null) {
      data['allergies'] = allergies?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? sId;
  String? name;
  bool? isActive;
  String? description;
  int? discount;
  bool? excludeDiscount;
  int? position;
  String? imageName;

  Category(
      {
        this.sId,
        this.name,
        this.isActive,
        this.description,
        this.discount,
        this.excludeDiscount,
        this.position,
        this.imageName});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    isActive = json['isActive'];
    description = json['description'];
    discount = json['discount'];
    excludeDiscount = json['excludeDiscount'];
    position = json['position'];
    imageName = json['imageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['isActive'] = isActive;
    data['description'] = description;
    data['discount'] = discount;
    data['excludeDiscount'] = excludeDiscount;
    data['position'] = position;
    data['imageName'] = imageName;
    return data;
  }
}

class Allergies {
  String? sId;
  String? description;
  String? createdOn;
  bool? isDeleted;
  String? restaurantId;
  String? name;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Allergies(
      {
        this.sId,
        this.description,
        this.createdOn,
        this.isDeleted,
        this.restaurantId,
        this.name,
        this.iV,
        this.createdAt,
        this.updatedAt});

  Allergies.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    createdOn = json['createdOn'];
    isDeleted = json['isDeleted'];
    restaurantId = json['restaurantId'];
    name = json['name'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['description'] = description;
    data['createdOn'] = createdOn;
    data['isDeleted'] = isDeleted;
    data['restaurantId'] = restaurantId;
    data['name'] = name;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}