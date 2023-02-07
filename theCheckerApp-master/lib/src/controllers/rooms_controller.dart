import 'package:dio/dio.dart';

import '../../src/controllers/basic.dart';
import 'package:get/get.dart';

import '../data/model/room_model.dart';
import '../data/repository/main_repository.dart';
import '../network/response.dart';
import '../storage/pref.dart';
import '../utils/utils.dart';

class RoomsController extends Basic {
  static RoomsController get to => Get.find();

  final MainRepository repository;
  RoomsController({required this.repository});

  // rooms filters
  // bed type
  final singleBedCheck = RxBool(false);
  final doubleBedCheck = RxBool(false);
  final suiteCheck = RxBool(false);
  // room status
  final freeCheck = RxBool(false);
  final occupiedCheck = RxBool(false);
  // cleaning
  final notCleanedCheck = RxBool(false);
  final inProgressCheck = RxBool(false);
  final cleanedCheck = RxBool(false);
  /////////

  final levelsList = RxList<Room>([]);
  final roomsList = RxList<Room>([]);

  getRooms() async {
    try {
      isLoading = true;
      ApiResponse result = await repository.rooms();
      final list = result.body['data']['rooms'];
      roomsList.value = Room.fromJsonList(list);
      log(this, 'rooms list ${list.length}');
      // log(this, 'rooms list ${list}');

      var set = <String?>{};
      levelsList.value =
          roomsList.where((element) => set.add(element.level?.id)).toList();
    } catch (e) {
      log(this, e);
    } finally {
      isLoading = false;
    }
  }

  var roomTypesList = RxList<String>([]);
  // list of RxBool
  var roomTypesChecks = RxList<RxBool>([]);

  getRoomTypes() async {
    String endPoint = "/room-type";

    Dio dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer ${Pref.to.tokenVal}';
    dio.get('http://35.178.46.228:3010$endPoint').then((response) {
      if (response.statusCode == 200) {
        List<dynamic> roomTypes = response.data["data"]["roomTypes"];
        for (var roomType in roomTypes) {
          print("Room Type: " + roomType["title"]);
          roomTypesList.add(roomType["title"]);
          roomTypesChecks.add(RxBool(false));
        }
      } else {
        print("Failed to get room types");
      }
    }).catchError((error) {
      print(error);
    });

    // "statusCode": 200,
    // "data": {
    //     "roomTypes": [
    //         {
    //             "_id": "639e3a9d359fbfa5a57ef605",
    //             "title": "double",
    //             "hotel": {
    //                 "_id": "639e39856a36c3c227837d03",
    //                 "username": "erfan"
    //             },
    //             "__v": 0,
    //             "price": 120
    //         },
    //     ]
    // }

    // extract title into roomTypesList
  }
}
