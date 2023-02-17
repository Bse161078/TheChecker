import 'package:checkerapp/src/network/response.dart';
import 'package:checkerapp/src/storage/pref.dart';
import 'package:checkerapp/src/ui/screen/splash/splash_page.dart';

import '../../src/controllers/basic.dart';
import '../data/repository/main_repository.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../utils/utils.dart';

class AuthController extends Basic {
  static AuthController get to => Get.find();

  final MainRepository repository;
  AuthController({required this.repository});

  // login variables
  final enabledLoginButton = RxBool(false);
  final obscurePass = RxBool(true);

  login(String userName, String pass) async {
    try {
      isLoading = true;
      log(this, "User Name: $userName and Password: $pass ");

      ApiResponse result = await repository.login(userName, pass);

      print("$this, Inside Auth Controller, Login Response ${result.body}");

      final role = result.body['data']['loginResult']['role'];
      print("Inside Auth Controller: role is: $role");
      final token = result.body['data']['loginResult']['accessToken'];
      print("Inside Auth Controller: token is: $token");
      Pref.to.setString(Pref.token, token);
      Pref.to.setString(Pref.role, role);

      if (role.toString().contains('Checker')) {
        Get.offNamed(Routes.DASHBOARD);
        Toast.success('you_are_login'.tr, 'login'.tr);
      } else if (role.toString().contains('HotelReception')) {
        late String hotelLogo;

        try {
          ApiResponse result = await repository.profile();

          print("Inside auth controller while logging in reception");
          print(result.body);

          final id = result.body['data']['user']['_id'];

          hotelLogo = result.body['data']['user']['hotel']['avatar'];
          print("This is the hotel logo in AUTH CONTROLLER: $hotelLogo");

          log(this, 'get profile info: ${result.body}');
        } catch (e) {
          log(this, e);
        }

        Get.to(() => Splash(
              hotelLogo: hotelLogo,
            ));

        Toast.success('you_are_login'.tr, 'login'.tr);
      } else {
        Toast.error('no_access'.tr);
      }
    } catch (e) {
      log(this, e);
      Toast.error(e.toString());
    } finally {
      isLoading = false;
    }
  }
}
