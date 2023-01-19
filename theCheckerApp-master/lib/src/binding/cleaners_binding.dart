
import 'package:checkerapp/src/controllers/cleaners_controller.dart';
import 'package:get/get.dart';
import '../data/repository/main_repository.dart';

class CleanersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CleanersController>(() {
      return CleanersController(
          repository: MainRepository());
    });
  }
}

