import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/rooms_controller.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  TextEditingController controllerSearchBox = TextEditingController();

  RoomsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX<RoomsController>(
      initState: (_) {
        controller.getRooms();
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
          // body: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ListView.separated(
          //     shrinkWrap: true,
          //     separatorBuilder: (context, index) => const Divider(
          //       color: Colors.grey,
          //       height: 1,
          //     ),
          //     itemCount: controller.notifNumber,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text("Room Name: ${controller.roomsList[index].name}")
          //             .setStyle(
          //           color: Colors.white,
          //           size: 20,
          //           weight: FontWeight.w500,
          //         ),
          //         trailing: IconButton(
          //           onPressed: () {},
          //           icon: const Icon(Icons.arrow_drop_down),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        );
      },
    );
  }
}
