
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../src/controllers/basic.dart';
import 'package:get/get.dart';

import '../data/repository/main_repository.dart';
import '../network/response.dart';
import '../routes/app_pages.dart';
import '../storage/pref.dart';
import '../utils/logger.dart';
import '../utils/toast.dart';

class DashboardController extends Basic {
  static DashboardController get to => Get.find();

  final MainRepository repository;
  DashboardController({required this.repository});


  getProfile() async{

    try{
      _getFCMToken();

      ApiResponse result = await repository.profile();
      final id = result.body['data']['user']['_id'];
      final name = result.body['data']['user']['fullname'];

      FirebaseMessaging.instance.subscribeToTopic(id);

      Pref.to.setString(Pref.id, id);
      Pref.to.setString(Pref.name, name);
      isLoading = true;
      isLoading = false;

      log(this, 'get profile info: ${result.body['data']}');
    }catch(e, s){
      log(this, e);
    }
  }

  _getFCMToken() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      log(this, 'FCM token: $value');
    });
  }

}