
import '../../src/controllers/basic.dart';
import 'package:get/get.dart';

import '../data/model/room_model.dart';
import '../data/repository/main_repository.dart';
import '../network/response.dart';
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

  getRooms() async{
    try{
      isLoading = true;
      ApiResponse result = await repository.rooms();
      final list = result.body['data']['rooms'];
      roomsList.value = Room.fromJsonList(list);
      log(this, 'rooms list ${list.length}');
      // log(this, 'rooms list ${list}');

      var set = <String?>{};
      levelsList.value = roomsList.where((element) => set.add(element.level?.id)).toList();

    }catch(e, s){
      log(this, e);
    }finally{
      isLoading = false;
    }
  }

}