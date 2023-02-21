// ignore_for_file: avoid_print

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
      log(this, "Error in get rooms $e");
    } finally {
      isLoading = false;
    }
  }

  setNotCleaned() async {
    print("Set not cleaned call");
    for (var p0 in roomsList) {
      print("Room Name: ${p0.name!}");
      if (p0.report!.contains("Clean Quick Guest Waiting")) {
        print("Inside If");
        ApiResponse result = await repository.setRoomStatus(
            p0.id!, "NotCleaned", p0.occupation_status!);
        print("Status: ${result.body!}");
      }
    }
  }

  var roomTypesList = RxList<String>([]);
  // list of RxBool
  var roomTypesChecks = RxList<RxBool>([]);

  getRoomTypes() async {
    String endPoint = "/room-type";

    Dio dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer ${Pref.to.tokenVal}';
    dio.get('https://184.169.179.30:3020$endPoint').then((response) {
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
  }

  var filteredRooms = RxList<Room>([]);
  var filteredLevelsList = RxList<Room>([]);

  searchRooms(String searchValue) {
    filteredRooms = roomsList
        .where((room) =>
            room.name!.toLowerCase().contains(searchValue.toLowerCase()))
        .toList()
        .obs;
    var set = <String?>{};
    filteredLevelsList = filteredRooms
        .where((element) => set.add(element.level?.id))
        .toList()
        .obs;
    update();
  }

  applyFilters() {
    // dont proceed if all filters are off
    if (!freeCheck.value &&
        !occupiedCheck.value &&
        !notCleanedCheck.value &&
        !inProgressCheck.value &&
        !cleanedCheck.value &&
        !roomTypesChecks.any((element) => element.value)) {
      resetFilters();
      return;
    }

    print("Applying Filters Function in $this");
    filteredRooms = roomsList
        .where((room) {
          bool thisIsTheRoom = false;

          print("${room.name} occupation status is ${room.occupation_status}");
          if (freeCheck.value) {
            if (room.occupation_status == "Free") {
              print("Insssside Free If: Room ${room.name} is free");
              thisIsTheRoom = true;
            }
          } else if (occupiedCheck.value) {
            if (room.occupation_status == "Occupied") {
              thisIsTheRoom = true;
            }
          }

          print("${room.name} cleaning status is ${room.status}");
          if (notCleanedCheck.value) {
            if (room.status == "Not Cleaned") {
              thisIsTheRoom = true;
            }
          } else if (inProgressCheck.value) {
            if (room.status == "IN_PROGRESS") {
              thisIsTheRoom = true;
            }
          } else if (cleanedCheck.value) {
            if (room.status == "Cleaned") {
              thisIsTheRoom = true;
            }
          }

          print("Room ${room.name} Type Is: ${room.roomType})");
          for (var i = 0; i < roomTypesChecks.length; i++) {
            if (roomTypesChecks[i].value) {
              // ignore: unrelated_type_equality_checks
              if (room.roomType == roomTypesList[i]) {
                thisIsTheRoom = true;
              }
            }
          }

          return thisIsTheRoom;
        })
        .toList()
        .obs;

    // remove duplicates
    var set = <String?>{};
    filteredRooms = filteredRooms
        .where((element) => set.add(element.level?.id))
        .toList()
        .obs;

    filteredLevelsList = filteredRooms
        .where((element) => element.level?.id != null)
        .toList()
        .obs;

    print("\n");

    update();
  }

  resetFilters() {
    print("Resetting Filters Function in $this");
    filteredRooms = roomsList;
    filteredLevelsList = levelsList;
    freeCheck.value = false;
    occupiedCheck.value = false;
    notCleanedCheck.value = false;
    inProgressCheck.value = false;
    cleanedCheck.value = false;
    for (var i = 0; i < roomTypesChecks.length; i++) {
      roomTypesChecks[i].value = false;
    }
    update();
  }

  int notifNumber = 0;

  int getNotifNumber() {
    for (var element in roomsList) {
      if (element.report!.isNotEmpty) {
        notifNumber++;
      }
    }
    return notifNumber;
  }
}
