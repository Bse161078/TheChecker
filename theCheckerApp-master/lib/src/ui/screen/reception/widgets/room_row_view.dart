import 'package:checkerapp/src/utils/ext/padding.dart';
import 'package:checkerapp/src/utils/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/report_notification_getter.dart';
import 'alert_view.dart';
import 'cleaning_actions_view.dart';
import 'damages_actions_view.dart';

/// Created by amir on 22, December, 2022

class RoomRowView extends StatefulWidget {
  final String label;
  final String type;
  final String cleaningStatus;
  final List<String>? reportsList;
  final VoidCallback onTapAlert;
  const RoomRowView(
      {Key? key,
      required this.label,
      required this.type,
      required this.cleaningStatus,
      required this.onTapAlert,
      required this.reportsList})
      : super(key: key);

  @override
  State<RoomRowView> createState() => _RoomRowViewState();
}

class _RoomRowViewState extends State<RoomRowView> {
  bool reportIsEmpty = true;

  double screenWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    print("Inside Room Row View: ${widget.label} has ${widget.type} type");
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              // 6 for big ipad
              flex: screenWidth > 800 ? 6 : 4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth > 800 ? 85 : 60,
                    child: Text(widget.label)
                        .setStyle(size: 22)
                        .paddingOnly(left: 18, top: 6, bottom: 6),
                  ),
                  Container(
                    child: IconButton(
                      icon: const Icon(Icons.info, color: Colors.grey),
                      onPressed: () {
                        if (widget.reportsList!.isEmpty) {
                          setState(() {
                            reportIsEmpty = true;
                          });
                        } else {
                          setState(() {
                            reportIsEmpty = false;
                          });
                        }
                        showRoomInfoDialog(context);
                      },
                    ),
                  ),
                  GestureDetector(
                    // show a popup with the text on long press
                    onLongPress: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 200,
                              width: 100,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Room Type",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      widget.type.tr,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 40),
                                    ),
                                  ],
                                ),
                              )),
                            );
                          });
                    },
                    child: SizedBox(
                      width: 110,
                      child: Text(
                        widget.type.tr,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ).setStyle(color: Get.theme.hintColor),
                    ),
                  ),
                ],
              ).paddingOnly(right: 30),
            ),
            Expanded(
                // 8 for big ipad
                flex: screenWidth > 800 ? 8 : 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CleaningActionsView(
                        state: getCleaningAction(widget.cleaningStatus)),
                    DamagesActionsView(
                      state: getDamagesAction(widget.cleaningStatus),
                    ),
                    AlertView(
                      onTap: widget.onTapAlert,
                    ),
                  ],
                )),
            16.pw,
          ],
        ).paddingOnly(top: 6, bottom: 4),
        const Divider(
          height: 4,
        ),
      ],
    );
  }

  CleaningActions getCleaningAction(String cleaningStatus) {
    if (cleaningStatus == 'Cleaned' || cleaningStatus == 'Damaged') {
      return CleaningActions.cleaned;
    } else if (cleaningStatus == "IN_PROGRESS") {
      return CleaningActions.inProgress;
    } else if (cleaningStatus == "null" || cleaningStatus == "") {
      return CleaningActions.notAvailable;
    } else {
      return CleaningActions.notCleaned;
    }
  }

  DamagesActions getDamagesAction(String cleaningStatus) {
    if (cleaningStatus == 'Damaged') {
      return DamagesActions.damaged;
    } else if (cleaningStatus == "null" || cleaningStatus == "") {
      return DamagesActions.notAvailable;
    } else {
      return DamagesActions.noDamages;
    }
  }

  void showRoomInfoDialog(BuildContext context) {
    // if nothing in the list, show no report available

    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SizedBox(
        width: Get.width / 2.2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12)),
              child: CupertinoNavigationBar(
                leading: CupertinoNavigationBarBackButton(
                  previousPageTitle: 'cancel'.tr,
                  onPressed: () {
                    Get.back();
                  },
                ),
                middle: Text("Room No: ${widget.label}"),
              ),
            ),
            if (!reportIsEmpty) 10.ph,
            if (!reportIsEmpty)
              const Text("Room Reports")
                  .setStyle(size: 16, weight: FontWeight.w500),
            10.ph,
            if (reportIsEmpty)
              const Text("No Room Report Available")
                  .setStyle(size: 16, weight: FontWeight.w500)
                  .paddingSymmetric(vertical: 10),
            if (widget.cleaningStatus.toString() == "Cleaned")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Room Is Cleaned",
                    style: Get.textTheme.titleMedium,
                  ).setStyle(size: 14, weight: FontWeight.w500),
                  const Icon(Icons.check, color: Colors.green),
                ],
              ).paddingAll(20),
            if (widget.cleaningStatus.toString() == "Damaged")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Room Is Damaged",
                    style: Get.textTheme.titleMedium,
                  ).setStyle(size: 14, weight: FontWeight.w500),
                  const Icon(Icons.close_rounded, color: Colors.red),
                ],
              ).paddingOnly(right: 20, left: 20, bottom: 20),
            for (var i = 0; i < widget.reportsList!.length; i++)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.reportsList![i],
                        style: Get.textTheme.titleMedium,
                      ).setStyle(size: 14, weight: FontWeight.w500),
                      ...getNotificationIcon(widget.reportsList![i]),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                  20.ph,
                ],
              )
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}
