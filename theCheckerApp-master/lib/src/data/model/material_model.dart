class Material {
  Material({
      this.id, 
      this.name, 
      this.nameDe, 
      this.price, 
      this.quantity, 
      this.hotel, 
      this.checker, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Material.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    nameDe = json['name_de'];
    price = json['price'];
    quantity = json['quantity'];
    hotel = json['hotel'] != null ? Hotel.fromJson(json['hotel']) : null;
    checker = json['checker'] != null ? Checker.fromJson(json['checker']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? name;
  String? nameDe;
  num? price;
  String? quantity;
  Hotel? hotel;
  Checker? checker;
  String? createdAt;
  String? updatedAt;
  num? v;
  bool? isChecked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['name_de'] = nameDe;
    map['price'] = price;
    map['quantity'] = quantity;
    if (hotel != null) {
      map['hotel'] = hotel?.toJson();
    }
    if (checker != null) {
      map['checker'] = checker?.toJson();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

  static List<Material> fromJsonList(List list) {
    return list.map((item) => Material.fromJson(item)).toList();
  }


}

class Checker {
  Checker({
      this.id, 
      this.fullname, 
      this.username,});

  Checker.fromJson(dynamic json) {
    id = json['_id'];
    fullname = json['fullname'];
    username = json['username'];
  }
  String? id;
  String? fullname;
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullname'] = fullname;
    map['username'] = username;
    return map;
  }

}

class Hotel {
  Hotel({
      this.id, 
      this.username,});

  Hotel.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
  }
  String? id;
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['username'] = username;
    return map;
  }

}