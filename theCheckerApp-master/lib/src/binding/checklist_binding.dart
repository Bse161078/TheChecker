
import '../../../../src/controllers/checklist_controller.dart';
import 'package:get/get.dart';
import '../data/repository/main_repository.dart';

class CheckListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckListController>(() {
      return CheckListController(
          repository: MainRepository());
    });
  }
}

