
import 'package:get/get.dart';


import '../controllers/auth_controller.dart';
import '../data/repository/main_repository.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() {
      return AuthController(
          repository: MainRepository());
    });
  }
}

