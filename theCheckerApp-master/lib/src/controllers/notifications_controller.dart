// ignore_for_file: avoid_print

import '../../src/controllers/basic.dart';
import 'package:get/get.dart';

import '../data/model/notification_model.dart';
import '../data/repository/main_repository.dart';
import '../utils/logger.dart';
import 'rooms_controller.dart';

class NotificationController extends Basic {
  static NotificationController get to => Get.find();

  final MainRepository repository;
  NotificationController({required this.repository});

  var notifNumber = RxInt(0);

  int getNotifNumber() {
    notifNumber = RxInt(0);
    for (var element in RoomsController.to.roomsList) {
      if (element.report!.isNotEmpty) {
        notifNumber++;
      }
    }
    return notifNumber.value;
  }

  final notificationsList = RxList<NotificationModel>([]);

  void getNotifications() async {
    try {
      for (var room in RoomsController.to.roomsList) {
        if (room.report!.isNotEmpty) {
          notificationsList.add(NotificationModel(
            roomName: room.name ?? "",
            reports: room.report ?? [],
            roomId: room.id ?? "",
          ));
        }
      }

      for (var notification in notificationsList) {
        print(notification.toString());
      }
    } catch (e) {
      log(this, "While filling notifications list: $e");
    }
  }
}
