import 'package:firebase_messaging/firebase_messaging.dart';

import '../../src/controllers/basic.dart';
import 'package:get/get.dart';

import '../data/repository/main_repository.dart';
import '../network/response.dart';
import '../storage/pref.dart';
import '../utils/logger.dart';

class DashboardController extends Basic {
  static DashboardController get to => Get.find();

  final MainRepository repository;
  DashboardController({required this.repository});

  getProfile() async {
    try {
      _getFCMToken();

      print("Inside dashboard controller");

      ApiResponse result = await repository.profile();
      print(result.body);
      final id = result.body['data']['user']['_id'];
      print("id is $id");
      final name = result.body['data']['user']['fullname'];
      Pref.to.setString(Pref.name, name);
      print("name is $name");

      final userAvatar = result.body['data']['user']['avatar'];
      print("userAvatar is $userAvatar");
      Pref.to.setString(Pref.userAvatar, userAvatar);

      var hotelLogo = result.body['data']['user']['hotel']['avatar'];
      print("hotelLogo is $hotelLogo");
      Pref.to.setString(Pref.hotelLogoChecker, hotelLogo);

      // print("id: $id");
      // print("name: $name");

      FirebaseMessaging.instance.subscribeToTopic(id);

      Pref.to.setString(Pref.id, id);
      Pref.to.setString(Pref.name, name);
      isLoading = true;
      isLoading = false;

      log(this, 'get profile info: ${result.body['data']}');
    } catch (e) {
      log(this, "error in dashboard controller $e");
    }
  }

  _getFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      log(this, 'FCM token: $value');
    });
  }
}
