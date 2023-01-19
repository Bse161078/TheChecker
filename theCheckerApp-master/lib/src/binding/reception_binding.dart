
import '../controllers/reception_controller.dart';
import 'package:get/get.dart';
import '../data/repository/main_repository.dart';

class ReceptionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceptionController>(() {
      return ReceptionController(
          repository: MainRepository());
    });
  }
}

