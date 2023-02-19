import 'package:checkerapp/src/controllers/materials_controller.dart';

import '../controllers/cleaners_controller.dart';
import '../controllers/notifications_controller.dart';
import '../controllers/rooms_controller.dart';
import 'package:get/get.dart';

import '../data/repository/main_repository.dart';
import '../storage/pref.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(Pref()).init();

    Get.put(RoomsController(repository: MainRepository()));
    Get.put(CleanersController(repository: MainRepository()));
    Get.put(MaterialsController(repository: MainRepository()));
    Get.put(NotificationController(repository: MainRepository()));
  }
}
