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

      ApiResponse result = await repository.profile();
      final id = result.body['data']['user']['_id'];
      final name = result.body['data']['user']['name'];

      // print("id: $id");
      // print("name: $name");

      FirebaseMessaging.instance.subscribeToTopic(id);

      Pref.to.setString(Pref.id, id);
      Pref.to.setString(Pref.name, name);
      isLoading = true;
      isLoading = false;

      log(this, 'get profile info: ${result.body['data']}');
    } catch (e) {
      // print("error in profile");
      log(this, e);
    }
  }

  _getFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      log(this, 'FCM token: $value');
    });
  }
}
