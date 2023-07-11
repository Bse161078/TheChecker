import 'package:checkerapp/src/ui/screen/reception/widgets/room_row_view.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../data/model/room_model.dart';
import '../../../storage/pref.dart';
import '../../widget/checker.dart';

import '../../../../src/ui/widget/textfield_widget.dart';
import '../../../../src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/reception_controller.dart';
import '../../../routes/app_pages.dart';
import '../../widget/button_widget.dart';
import '../../widget/tap_widget.dart';
import 'widgets/send_alert_dialog.dart';

class Reception extends StatefulWidget {
  const Reception({super.key});

  @override
  State<Reception> createState() => _ReceptionState();
}

class _ReceptionState extends State<Reception> {
  TextEditingController controllerSearchBox = TextEditingController();

  ReceptionController controller = Get.find();

  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    return GetX<ReceptionController>(initState: (_) {
      // make a full screen container that vanishes after 4 seconds

      controller.getRooms();
      controller.getProfile();

      screenWidth = Get.width;
      print(screenWidth);

      controller.filteredRoomsList = controller.roomsList;
    }, builder: (receptionController) {
      receptionController.isLoading;

      return Scaffold(
          appBar: CupertinoNavigationBar(
            middle: Text('rooms'.tr),
            automaticallyImplyLeading: false,
            trailing: Tap(
              onTap: () => _showSignoutDialog(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('sign_out'.tr)
                      .setStyle(color: Colors.red, weight: FontWeight.w500),
                  6.pw,
                  const Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              18.ph,
              // search bar
              Row(
                children: [
                  Flexible(
                    child: TxtField(
                      controller: controllerSearchBox,
                      label: 'search_room'.tr,
                      hasSearchIcon: true,
                    ),
                  ),
                  8.pw,
                  SizedBox(
                    width: 130,
                    height: 47,
                    child: Btn(
                      label: 'filter'.tr,
                      secondaryBtn: true,
                      onPressed: () => _showFilterDialog(context),
                    ),
                  ),
                  8.pw,
                  SizedBox(
                    width: 130,
                    height: 47,
                    child: Btn(
                      label: 'search'.tr,
                      onPressed: () {
                        print("Searched value is: ${controllerSearchBox.text}");
                        setState(() {
                          controller
                              .searchReceptionRooms(controllerSearchBox.text);
                        });
                      },
                    ),
                  ),
                  // 8.pw,
                  // SizedBox(width: 130, height: 47, child: Btn(label: 'bulk_actions'.tr, secondaryBtn: true, iconData: Icons.keyboard_arrow_down_rounded, iconColor: Get.theme.primaryColor,direction: TextDirection.rtl, onPressed: (){})),
                ],
              ),

              38.ph,

              if (receptionController.isLoading) ...[
                const Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                )
              ] else ...[
                // header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      // 6 for big i pad,
                      flex: 6,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'room'.tr,
                            style: Get.textTheme.titleMedium,
                          ).setStyle(size: 14).paddingOnly(left: 16),
                          const Text("Room Alerts").setStyle(size: 14),
                          Text(
                            'Room Type',
                            style: Get.textTheme.titleMedium,
                          ).setStyle(size: 14),
                        ],
                      ).paddingOnly(right: 50),
                    ),
                    Expanded(
                      // 8 for big ipad
                      flex: screenWidth > 800 ? 8 : 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 150,
                              child: Text(
                                'status'.tr,
                                style: Get.textTheme.titleMedium,
                              ).setStyle(size: 14).paddingOnly(left: 20)),
                          SizedBox(
                              width: 150,
                              child: Text(
                                'damages'.tr,
                                style: Get.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ).setStyle(size: 14).paddingOnly(right: 40)),
                          SizedBox(
                              width: screenWidth > 800 ? 150 : 70,
                              child: Text(
                                'alert'.tr,
                                style: Get.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ).setStyle(size: 14).paddingOnly(left: 0)),
                        ],
                      ),
                    ),
                    16.pw,
                  ],
                ).paddingOnly(top: 6, bottom: 4),

                Expanded(
                  child: Container(
                    // height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Get.theme.splashColor,
                    ),
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        // Room model = receptionController.roomsList[index];
                        Room model = controller.filteredRoomsList[index];
                        print(
                            "Inside reception page ${model.name} has ${model.roomType}");
                        return RoomRowView(
                          label: '${model.name}',
                          type: '${model.roomType}',
                          cleaningStatus: '${model.status}',
                          reportsList: model.report,
                          onTapAlert: () {
                            _submitAlertDialog(context, model);
                          },
                        );
                      },
                      itemCount: controller.filteredRoomsList.length,
                    ),
                  ),
                ),
              ]
            ],
          ).paddingSymmetric(horizontal: 16));
    });
  }

  void _showFilterDialog(BuildContext context) async {
    controller.receptionRoomTypesList = RxList<String>([]);
    await controller.getRoomTypes();

    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SingleChildScrollView(
        child: SizedBox(
          width: Get.width / 1.8,
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12)),
                  child: CupertinoNavigationBar(
                    leading: CupertinoNavigationBarBackButton(
                      previousPageTitle: 'cancel'.tr,
                      onPressed: () => Get.back(),
                    ),
                    trailing: Tap(
                      onTap: () {
                        setState(() {
                          controller.resetFilters();
                        });
                        Get.back();
                      },
                      child: Text('reset'.tr).setStyle(color: Colors.red),
                    ),
                    middle: Text('filter_rooms'.tr),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Room Type'.tr,
                      style: Get.textTheme.titleMedium,
                    )
                        .setStyle(size: 14, weight: FontWeight.w500)
                        .paddingOnly(left: 24, top: 24),
                  ],
                ),
                8.ph,
                for (int i = 0;
                    i < controller.receptionRoomTypesList.length;
                    i += 2)
                  Row(
                    children: [
                      Expanded(
                        child: Checker(
                          label: controller.receptionRoomTypesList[i],
                          state: controller.receptionRoomTypesChecks[i].value,
                          type: CheckerType.Check,
                          onChanged: (newValue) => {
                            controller.receptionRoomTypesChecks[i].value =
                                newValue
                          },
                          longText: false,
                        ),
                      ),
                      16.pw,
                      if (i + 1 < controller.receptionRoomTypesList.length)
                        Expanded(
                          child: Checker(
                            label: controller.receptionRoomTypesList[i + 1],
                            state: controller
                                .receptionRoomTypesChecks[i + 1].value,
                            type: CheckerType.Check,
                            onChanged: (newValue) => {
                              controller.receptionRoomTypesChecks[i + 1].value =
                                  newValue
                            },
                            longText: false,
                          ),
                        ),
                    ],
                  ).paddingSymmetric(horizontal: 24, vertical: 12),
                Row(
                  children: [
                    Text(
                      'Occupation Status',
                      style: Get.textTheme.titleMedium,
                    )
                        .setStyle(size: 14, weight: FontWeight.w500)
                        .paddingOnly(left: 24, top: 24),
                  ],
                ),
                8.ph,
                Row(
                  children: [
                    Expanded(
                      child: Checker(
                          label: 'free'.tr,
                          state: controller.freeCheck.value,
                          type: CheckerType.Check,
                          onChanged: (newValue) =>
                              controller.freeCheck.value = newValue,
                          longText: false),
                    ),
                    16.pw,
                    Expanded(
                      child: Checker(
                        label: 'occupied'.tr,
                        state: controller.occupiedCheck.value,
                        type: CheckerType.Check,
                        onChanged: (newValue) =>
                            controller.occupiedCheck.value = newValue,
                        longText: false,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 24),
                Row(
                  children: [
                    Text(
                      'cleaning'.tr,
                      style: Get.textTheme.titleMedium,
                    )
                        .setStyle(size: 14, weight: FontWeight.w500)
                        .paddingOnly(left: 24, top: 24),
                  ],
                ),
                8.ph,
                Row(
                  children: [
                    Expanded(
                      child: Checker(
                          label: 'not_cleaned'.tr,
                          state: controller.notCleanedCheck.value,
                          type: CheckerType.Check,
                          onChanged: (newValue) =>
                              controller.notCleanedCheck.value = newValue,
                          longText: false),
                    ),
                    16.pw,
                    Expanded(
                      child: Checker(
                          label: 'in_progress'.tr,
                          state: controller.inProgressCheck.value,
                          type: CheckerType.Check,
                          onChanged: (newValue) =>
                              controller.inProgressCheck.value = newValue,
                          longText: false),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 24),
                12.ph,
                Row(
                  children: [
                    Expanded(
                      child: Checker(
                          label: 'cleaned'.tr,
                          state: controller.cleanedCheck.value,
                          type: CheckerType.Check,
                          onChanged: (newValue) =>
                              controller.cleanedCheck.value = newValue,
                          longText: false),
                    ),
                    16.pw,
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 24),
                42.ph,
                SizedBox(
                  width: Get.width / 4.8,
                  child: Btn(
                    label: 'apply_filters'.tr,
                    onPressed: () {
                      print("Applying filters pressed");
                      setState(() {
                        controller.applyFilters();
                      });
                      Get.back();
                    },
                  ),
                ),
                24.ph,
              ],
            ),
          ),
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return errorDialog;
        });
  }

  void _showSignoutDialog(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SizedBox(
        width: Get.width / 2.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12)),
              child: CupertinoNavigationBar(
                leading: CupertinoNavigationBarBackButton(
                  previousPageTitle: 'cancel'.tr,
                  onPressed: () => Get.back(),
                ),
                middle: Text('sign_out'.tr),
              ),
            ),
            Row(
              children: [
                Text(
                  'want_to_sign_out'.tr,
                  style: Get.textTheme.titleMedium,
                ).setStyle(size: 16).paddingOnly(left: 24, top: 24),
              ],
            ),
            34.ph,
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Btn(
                        label: 'cancel'.tr,
                        onPressed: () => Get.back(),
                        direction: TextDirection.rtl,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 9))),
                16.pw,
                Expanded(
                    flex: 1,
                    child: Btn(
                      label: 'sign_out'.tr,
                      onPressed: () {
                        Pref.to.clear();
                        Get.offNamed(Routes.SPLASH);
                        // try {
                        //   FirebaseMessaging.instance
                        //       .unsubscribeFromTopic(Pref.to.idVal);
                        // } catch (e) {
                        //   log(this, 'e: $e');
                        // }
                      },
                      secondaryBtn: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 7),
                    )),
              ],
            ).paddingSymmetric(horizontal: 24),
            24.ph,
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  _submitAlertDialog(BuildContext context, Room room) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SendAlertDialog(
        room: room,
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}
