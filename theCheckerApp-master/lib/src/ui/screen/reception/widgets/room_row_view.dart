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
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.label)
                      .setStyle(size: 22)
                      .paddingOnly(left: 18, top: 6, bottom: 6),
                  IconButton(
                    icon: const Icon(Icons.info, color: Colors.grey),
                    onPressed: () {
                      if (widget.reportsList!.isEmpty) {
                        print("Reports List is empty");
                        setState(() {
                          reportIsEmpty = true;
                        });
                      } else {
                        print("Reports List is not empty");
                        print(widget.reportsList!.length);
                        print(widget.reportsList);
                        setState(() {
                          reportIsEmpty = false;
                        });
                      }
                      showRoomInfoDialog(context);
                    },
                  ),
                  Text(widget.type.tr).setStyle(color: Get.theme.hintColor),
                ],
              ).paddingOnly(right: 40),
            ),
            Expanded(
                flex: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CleaningActionsView(
                      state: (widget.cleaningStatus == 'Cleaned' ||
                              widget.cleaningStatus == 'Damaged')
                          ? CleaningActions.cleaned
                          : (widget.cleaningStatus == "null" ||
                                  widget.cleaningStatus == "")
                              ? CleaningActions.notAvailable
                              : CleaningActions.notCleaned,
                    ),
                    DamagesActionsView(
                      state: (widget.cleaningStatus == 'Damaged')
                          ? DamagesActions.damaged
                          : (widget.cleaningStatus == "" ||
                                  widget.cleaningStatus == "null")
                              ? DamagesActions.notAvailable
                              : DamagesActions.noDamages,
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
            10.ph,
            if (reportIsEmpty)
              const Text("No Room Report Available")
                  .setStyle(size: 16, weight: FontWeight.w500)
                  .paddingSymmetric(vertical: 10),
            if (widget.cleaningStatus.toString() == "Cleaned")
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
            if (widget.cleaningStatus.toString() == "Damaged")
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
