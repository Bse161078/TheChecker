import 'level_model.dart';

class Room {
  Room({
    this.id,
    this.name,
    this.nameDe,
    this.status,
    this.report,
    this.roomType,
    this.level,
    this.hotel,
    this.occupation_status,
  });

  Room.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    nameDe = json['name_de'];
    status = json['status'];
    report = json['report'];
    roomType =
        json['roomType'] != null ? RoomType.fromJson(json['roomType']) : null;
    level = json['level'] != null ? Level.fromJson(json['level']) : null;
    hotel = json['hotel'];
    occupation_status = json['occupation_status'];
  }
  String? id;
  String? name;
  String? nameDe;
  String? status;
  String? report;
  RoomType? roomType;
  Level? level;
  String? hotel;
  String? occupation_status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['name_de'] = nameDe;
    map['status'] = status;
    map['report'] = report;
    map['occupation_status'] = occupation_status;
    if (roomType != null) {
      map['roomType'] = roomType?.toJson();
    }
    if (level != null) {
      map['level'] = level?.toJson();
    }
    map['hotel'] = hotel;
    return map;
  }

  static List<Room> fromJsonList(List list) {
    return list.map((item) => Room.fromJson(item)).toList();
  }
}

class RoomType {
  RoomType({
    this.id,
    this.title,
  });

  RoomType.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
  }
  String? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    return map;
  }
}
