
import 'package:get/get.dart';
import '../controllers/rooms_controller.dart';
import '../data/repository/main_repository.dart';

class RoomsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomsController>(() {
      return RoomsController(
          repository: MainRepository());
    });
  }
}

