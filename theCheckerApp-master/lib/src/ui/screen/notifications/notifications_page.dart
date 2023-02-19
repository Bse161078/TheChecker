import 'package:checkerapp/src/controllers/notifications_controller.dart';
import 'package:checkerapp/src/utils/report_notification_getter.dart';
import 'package:checkerapp/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  TextEditingController controllerSearchBox = TextEditingController();

  NotificationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX<NotificationController>(
      initState: (_) {
        controller.getNotifNumber();
        controller.getNotifications();
      },
      builder: (notifController) {
        print("Rebuilding Notifications Page");
        notifController.isLoading;

        return Scaffold(
          appBar: CupertinoNavigationBar(
            middle: Text('Notifications'.tr),
            leading: CupertinoNavigationBarBackButton(
              previousPageTitle: 'home'.tr,
              onPressed: () => Get.back(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                height: 1,
              ),
              itemCount: controller.notifNumber.value,
              itemBuilder: (context, index) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Get.theme.splashColor,
                  contentPadding: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  title: Text(
                          "Room :  ${controller.notificationsList[index].roomName}")
                      .setStyle(
                    color: Colors.white,
                    size: 24,
                    weight: FontWeight.w500,
                  ),
                  subtitle: Container(
                    height:
                        controller.notificationsList[index].reports.length * 30,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0;
                            i <
                                controller
                                    .notificationsList[index].reports.length;
                            i++)
                          Row(
                            children: [
                              Text(controller
                                      .notificationsList[index].reports[i])
                                  .setStyle(
                                color: Colors.white,
                                size: 20,
                                weight: FontWeight.w500,
                              ),
                              ...getNotificationIcon(controller
                                  .notificationsList[index].reports[i]),
                            ],
                          ),
                      ],
                    ),
                  ).paddingOnly(top: 20, bottom: 20),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
