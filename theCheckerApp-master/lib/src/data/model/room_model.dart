// ignore_for_file: avoid_print

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

  String? id;
  String? name;
  String? nameDe;
  String? status;
  List<String>? report;
  String? roomType;
  Level? level;
  String? hotel;
  String? occupation_status;

  Room.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    nameDe = json['name_de'];
    status = json['cleaning_status'];

    report = json["report"] != null ? List<String>.from(json["report"]) : null;

    roomType = json['roomType'];
    level = json['level'] != null ? Level.fromJson(json['level']) : null;
    hotel = json['hotel'];
    occupation_status = json['occupation_status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['name_de'] = nameDe;
    map['cleaning_status'] = status;
    map['report'] = report;
    map['occupation_status'] = occupation_status;
    map['roomType'] = roomType;
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
