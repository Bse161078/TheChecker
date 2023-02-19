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

  bool expanded = false;

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
                color: Colors.red,
                height: 1,
              ),
              itemCount: controller.notifNumber.value,
              itemBuilder: (context, index) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Get.theme.splashColor,
                  onTap: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  },
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
                  subtitle: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    height: expanded
                        ? controller.notificationsList[index].reports.length *
                            30
                        : 0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: expanded
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0;
                                  i <
                                      controller.notificationsList[index]
                                          .reports.length;
                                  i++)
                                Row(
                                  children: [
                                    Text(controller.notificationsList[index]
                                            .reports[i])
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
                          )
                        : null,
                  ).paddingOnly(
                      top: expanded ? 20 : 0, bottom: expanded ? 20 : 0),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        expanded = !expanded;
                      });
                    },
                    icon: Icon(
                      expanded
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined,
                      size: 30,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
