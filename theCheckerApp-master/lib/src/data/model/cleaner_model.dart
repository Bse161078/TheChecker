class Cleaner {
  Cleaner({
    this.id,
    this.fullname,
    this.avatar,
    this.username,
    // this.hotel,
    this.startAt,
    this.endAt,
    this.salaryPerRoom,
    this.roomCountForCleanEachDay,
    this.createdAt,
    this.updatedAt,
  });

  Cleaner.fromJson(dynamic json) {
    id = json['_id'];
    fullname = json['fullname'];
    avatar = json['avatar'];
    username = json['username'];
    // hotel = json['hotel'];
    startAt = json['startAt'];
    endAt = json['endAt'];
    salaryPerRoom = json['salaryPerRoom'];
    roomCountForCleanEachDay = json['roomCountForCleanEachDay'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? fullname;
  String? avatar;
  String? username;
  // String? hotel;
  String? startAt;
  String? endAt;
  String? salaryPerRoom;
  String? roomCountForCleanEachDay;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullname'] = fullname;
    map['avatar'] = avatar;
    map['username'] = username;
    // map['hotel'] = hotel;
    map['startAt'] = startAt;
    map['endAt'] = endAt;
    map['salaryPerRoom'] = salaryPerRoom;
    map['roomCountForCleanEachDay'] = roomCountForCleanEachDay;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

  static List<Cleaner> fromJsonList(List list) {
    return list.map((item) => Cleaner.fromJson(item)).toList();
  }
}
