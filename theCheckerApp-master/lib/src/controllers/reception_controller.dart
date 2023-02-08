import 'package:firebase_messaging/firebase_messaging.dart';

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
  ReceptionController({required this.repository});

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

  final roomsList = RxList<Room>([]);

  getRooms() async {
    try {
      isLoading = true;
      ApiResponse result = await repository.rooms();
      final list = result.body['data']['rooms'];
      print("data : ${list.toString()}");
      roomsList.value = Room.fromJsonList(list);
      log(this, 'rooms list ${list.length}');
    } catch (e, s) {
      log(this, 'rooms error x $e $s');
    } finally {
      isLoading = false;
    }
  }

  getProfile() async {
    try {
      ApiResponse result = await repository.profile();
      final id = result.body['data']['user']['_id'];
      // final name = result.body['data']['user']['fullname'];

      FirebaseMessaging.instance.subscribeToTopic(id);

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
}
