// ignore_for_file: avoid_print, unused_local_variable, non_constant_identifier_names

import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import '../../src/controllers/basic.dart';
import 'package:get/get.dart';
import '../data/model/room_model.dart';
import '../data/repository/main_repository.dart';
import '../network/response.dart';
import '../storage/pref.dart';
import '../utils/logger.dart';

class ReceptionController extends Basic {
  static ReceptionController get to => Get.find();

  final MainRepository repository;
  ReceptionController({required this.repository}) {
    // everyFilter.add(singleBedCheck);
    // everyFilter.add(doubleBedCheck);
    // everyFilter.add(suiteCheck);
    // everyFilter.add(freeCheck);
    // everyFilter.add(occupiedCheck);
    // everyFilter.add(notCleanedCheck);
    // everyFilter.add(inProgressCheck);
    // everyFilter.add(cleanedCheck);

    // for (var element in receptionRoomTypesChecks) {
    //   everyFilter.add(element);
    // }
  }

  // rooms filters
  // bed type

  // room status
  final freeCheck = RxBool(false);
  final occupiedCheck = RxBool(false);
  // cleaning
  final notCleanedCheck = RxBool(false);
  final inProgressCheck = RxBool(false);
  final cleanedCheck = RxBool(false);

  final roomsList = RxList<Room>([]);

  getRooms() async {
    try {
      isLoading = true;
      ApiResponse result = await repository.rooms();
      final list = result.body['data']['rooms'];
      print(
          "data from api response in reception controller : ${list.toString()}");
      roomsList.value = Room.fromJsonList(list);
      log(this, 'Inside reception controller rooms list is ${list.length}');
    } catch (e) {
      log(this, 'rooms error $e ');
    } finally {
      isLoading = false;
    }
  }

  getProfile() async {
    try {
      ApiResponse result = await repository.profile();
      final id = result.body['data']['user']['_id'];
      // final name = result.body['data']['user']['fullname'];

      // FirebaseMessaging.instance.subscribeToTopic(id);

      Pref.to.setString(Pref.id, id);
      // Pref.to.setString(Pref.name, name);
      // isLoading = true;
      // isLoading = false;

      log(this, 'get profile info: ${result.body['data']}');
    } catch (e) {
      log(this, e);
    }
  }

  var filteredRoomsList = RxList<Room>([]);

  searchReceptionRooms(String searchValue) {
    print('$this, Searching Reception Rooms');
    filteredRoomsList = roomsList
        .where(
          (room) => room.name!.toLowerCase().contains(
                searchValue.toLowerCase(),
              ),
        )
        .toList()
        .obs;
    update();

    for (var i = 0; i < filteredRoomsList.length; i++) {
      print(filteredRoomsList[i].name);
    }
  }

  var receptionRoomTypesList = RxList<String>([]);
  // list of RxBool
  var receptionRoomTypesChecks = RxList<RxBool>([]);

  getRoomTypes() async {
    String endPoint = "/room-type";

    Dio dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer ${Pref.to.tokenVal}';
    dio.get('https://184.169.179.30:3020$endPoint').then((response) {
      if (response.statusCode == 200) {
        List<dynamic> roomTypes = response.data["data"]["roomTypes"];
        for (var roomType in roomTypes) {
          print("Room Type: " + roomType["title"]);
          receptionRoomTypesList.add(roomType["title"]);
          receptionRoomTypesChecks.add(RxBool(false));
        }
      } else {
        print("Failed to get room types");
      }
    }).catchError((error) {
      print(error);
    });
  }

  // var everyFilter = RxList<RxBool>([]);

  applyFilters() {
    print("Applying Filters Function in $this");
    if (!freeCheck.value &&
        !occupiedCheck.value &&
        !notCleanedCheck.value &&
        !inProgressCheck.value &&
        !cleanedCheck.value &&
        !receptionRoomTypesChecks.any((element) => element.value)) {
      resetFilters();
      return;
    }
    filteredRoomsList = roomsList
        .where((room) {
          bool this_is_the_room = false;
          if (freeCheck.value) {
            if (room.occupation_status == "Free") {
              this_is_the_room = true;
            }
          } else if (occupiedCheck.value) {
            if (room.occupation_status == "Occupied") {
              this_is_the_room = true;
            }
          }

          print("${room.name} cleaning status is ${room.status}");
          if (notCleanedCheck.value) {
            if (room.status == "Not Cleaned") {
              this_is_the_room = true;
            }
          } else if (inProgressCheck.value) {
            if (room.status == "In Progress") {
              this_is_the_room = true;
            }
          } else if (cleanedCheck.value) {
            if (room.status == "Cleaned") {
              this_is_the_room = true;
            }
          }

          print("Room ${room.name} Type Is: ${room.roomType})");
          for (var i = 0; i < receptionRoomTypesChecks.length; i++) {
            if (receptionRoomTypesChecks[i].value) {
              if (room.roomType == receptionRoomTypesList[i]) {
                this_is_the_room = true;
              }
            }
          }

          return this_is_the_room;
        })
        .toList()
        .obs;
    update();

    for (var i = 0; i < filteredRoomsList.length; i++) {
      print("Rooms after filter: ${filteredRoomsList[i].name}");
    }
  }

  resetFilters() {
    print("Resetting Filters Function in $this");
    filteredRoomsList = roomsList;
    freeCheck.value = false;
    occupiedCheck.value = false;
    notCleanedCheck.value = false;
    inProgressCheck.value = false;
    cleanedCheck.value = false;
    for (var i = 0; i < receptionRoomTypesChecks.length; i++) {
      receptionRoomTypesChecks[i].value = false;
    }
    update();
  }
}
