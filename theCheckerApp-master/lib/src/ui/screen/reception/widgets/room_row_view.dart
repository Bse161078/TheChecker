import 'package:checkerapp/src/utils/ext/padding.dart';
import 'package:checkerapp/src/utils/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import 'alert_view.dart';
import 'cleaning_actions_view.dart';
import 'damages_actions_view.dart';

/// Created by amir on 22, December, 2022

class RoomRowView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    print("Inside Room Row View: $label has $type type");
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label)
                      .setStyle(size: 22)
                      .paddingOnly(left: 18, top: 6, bottom: 6),
                  IconButton(
                    icon: const Icon(Icons.info, color: Colors.grey),
                    onPressed: () {
                      showRoomInfoDialog(context);
                    },
                  ),
                  Text(type.tr).setStyle(color: Get.theme.hintColor),
                ],
              ).paddingOnly(right: 40),
            ),
            Expanded(
                flex: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CleaningActionsView(
                      state: (cleaningStatus == 'Cleaned' ||
                              cleaningStatus == 'Damaged')
                          ? CleaningActions.cleaned
                          : (cleaningStatus == "null" || cleaningStatus == "")
                              ? CleaningActions.notAvailable
                              : CleaningActions.notCleaned,
                    ),
                    DamagesActionsView(
                      state: (cleaningStatus == 'Damaged')
                          ? DamagesActions.damaged
                          : (cleaningStatus == "" || cleaningStatus == "null")
                              ? DamagesActions.notAvailable
                              : DamagesActions.noDamages,
                    ),
                    AlertView(
                      onTap: onTapAlert,
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

  void showRoomInfoDialog(BuildContext context) {
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
                middle: Text("Room No: $label"),
              ),
            ),
            10.ph,
            if (cleaningStatus.toString() == "Cleaned")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.check, color: Colors.green),
                  Text(
                    "Room Is Cleaned",
                    style: Get.textTheme.titleMedium,
                  ).setStyle(size: 14, weight: FontWeight.w500)
                ],
              ).paddingAll(20),
            if (cleaningStatus.toString() == "Damaged")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.close_rounded, color: Colors.red),
                  Text(
                    "Room Is Damaged",
                    style: Get.textTheme.titleMedium,
                  ).setStyle(size: 14, weight: FontWeight.w500)
                ],
              ).paddingOnly(right: 20, left: 20, bottom: 20),
            for (var i = 0; i < reportsList!.length; i++)
              if (reportsList![i] == 'Clean Quick Guest Waiting')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Get.theme.highlightColor,
                    ),
                    Text(
                      "Clean Quick Guest Waiting",
                      style: Get.textTheme.titleMedium,
                    ).setStyle(size: 14, weight: FontWeight.w500)
                  ],
                ).paddingOnly(right: 20, left: 20, bottom: 20),
            for (var i = 0; i < reportsList!.length; i++)
              if (reportsList![i] == 'Extra Bed Normal')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.bed,
                      color: Get.theme.highlightColor,
                    ),
                    Text(
                      "Extra Bed Normal",
                      style: Get.textTheme.titleMedium,
                    ).setStyle(size: 14, weight: FontWeight.w500)
                  ],
                ).paddingOnly(right: 20, left: 20, bottom: 20),
            for (var i = 0; i < reportsList!.length; i++)
              if (reportsList![i] == 'Extra Bed Child')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.child_friendly,
                      color: Get.theme.highlightColor,
                    ),
                    Text(
                      "Extra Bed Child",
                      style: Get.textTheme.titleMedium,
                    ).setStyle(size: 14, weight: FontWeight.w500)
                  ],
                ).paddingOnly(right: 20, left: 20, bottom: 20),
            for (var i = 0; i < reportsList!.length; i++)
              if (reportsList![i] == 'Red Card')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4, top: 4, left: 4),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: redColor,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    Text(
                      "Red Card",
                      style: Get.textTheme.titleMedium,
                    ).setStyle(size: 14, weight: FontWeight.w500)
                  ],
                ).paddingOnly(right: 20, left: 20, bottom: 20),
            for (var i = 0; i < reportsList!.length; i++)
              if (reportsList![i] == 'Clean Stay')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4, top: 4),
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                          color: Colors.amber, shape: BoxShape.circle),
                    ),
                    Text(
                      "Clean Stay",
                      style: Get.textTheme.titleMedium,
                    ).setStyle(size: 14, weight: FontWeight.w500)
                  ],
                ).paddingOnly(right: 20, left: 20, bottom: 20),
            for (var i = 0; i < reportsList!.length; i++)
              if (reportsList![i] == 'Clean Checkout')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4, top: 4),
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                          color: greenColor, shape: BoxShape.circle),
                    ),
                    Text(
                      "Clean Checkout",
                      style: Get.textTheme.titleMedium,
                    ).setStyle(size: 14, weight: FontWeight.w500)
                  ],
                ).paddingOnly(right: 20, left: 20, bottom: 20),
            for (var i = 0; i < reportsList!.length; i++)
              if (reportsList![i] == 'Clean Again')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.sync_problem_rounded,
                      color: redColor,
                    ),
                    Text(
                      "Clean Again",
                      style: Get.textTheme.titleMedium,
                    ).setStyle(size: 14, weight: FontWeight.w500)
                  ],
                ).paddingOnly(right: 20, left: 20, bottom: 20),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}
