
import 'package:checkerapp/src/controllers/materials_controller.dart';
import 'package:get/get.dart';
import '../controllers/rooms_controller.dart';
import '../data/repository/main_repository.dart';

class MaterialsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaterialsController>(() {
      return MaterialsController(
          repository: MainRepository());
    });
  }
}

