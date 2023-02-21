import 'package:checkerapp/src/ui/theme/app_colors.dart';
import 'package:checkerapp/src/utils/report_notification_getter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../src/utils/utils.dart';

class RoomBox extends StatefulWidget {
  final String title;
  final String type;
  final List<String>? report;
  final String status;
  final VoidCallback? onTap;
  const RoomBox(
      {Key? key,
      this.onTap,
      required this.title,
      required this.type,
      required this.report,
      required this.status})
      : super(key: key);

  @override
  State<RoomBox> createState() => _RoomBoxState();
}

class _RoomBoxState extends State<RoomBox> {
  bool reportIsEmpty = true;
  @override
  Widget build(BuildContext context) {
    print("Inside room box");
    for (var i = 0; i < widget.report!.length; i++) {
      print(widget.report![i]);
    }
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: widget.onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Get.theme.splashColor,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: Get.theme.textTheme.titleMedium,
                ).setStyle(size: 26, weight: FontWeight.bold),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'suite'.toPng,
                      width: 25,
                      height: 15,
                      fit: BoxFit.cover,
                    ),
                    2.ph,
                    Text(
                      widget.type,
                      style: Get.theme.textTheme.titleMedium,
                    ).setStyle(weight: FontWeight.w600, size: 12),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      if (widget.status.toString() == 'Cleaned') ...[
                        const Icon(
                          Icons.check,
                          color: greenColor,
                        ),
                        8.ph,
                      ],
                      if (widget.status.toString() == 'Damaged') ...[
                        const Icon(
                          Icons.close_rounded,
                          color: redColor,
                        ),
                        8.ph,
                      ],
                      if (widget.status.toString() == 'IN_PROGRESS') ...[
                        const Icon(
                          Icons.timelapse_outlined,
                          color: Colors.amber,
                        ),
                        8.ph,
                      ],
                    ],
                  ),
                ),

                //////////////////// reports
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      10.ph,
                      for (var i = 0; i < widget.report!.length; i++)
                        if (widget.report![i] ==
                            'Clean Quick Guest Waiting') ...[
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Get.theme.highlightColor,
                            size: 20,
                          ),
                          10.ph,
                        ],
                      for (var i = 0; i < widget.report!.length; i++)
                        if (widget.report![i] == 'Extra Bed Normal') ...[
                          Icon(
                            Icons.bed,
                            color: Get.theme.highlightColor,
                            size: 20,
                          ),
                          10.ph,
                        ],
                      for (var i = 0; i < widget.report!.length; i++)
                        if (widget.report![i] == 'Extra Bed Child') ...[
                          Icon(
                            Icons.child_friendly,
                            color: Get.theme.highlightColor,
                            size: 20,
                          ),
                          10.ph,
                        ],
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  if (widget.report!.isEmpty) {
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
                child: const SizedBox(
                  child: Icon(
                    Icons.info_outline_rounded,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              left: 0,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    for (var i = 0; i < widget.report!.length; i++)
                      if (widget.report![i] == 'Red Card') ...[
                        Container(
                          margin:
                              const EdgeInsets.only(right: 4, top: 4, left: 4),
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: redColor,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        5.pw,
                      ],
                    for (var i = 0; i < widget.report!.length; i++)
                      if (widget.report![i] == 'Clean Stay') ...[
                        Container(
                          margin: const EdgeInsets.only(right: 4, top: 4),
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                              color: Colors.amber, shape: BoxShape.circle),
                        ),
                        5.pw,
                      ],
                    for (var i = 0; i < widget.report!.length; i++)
                      if (widget.report![i] == 'Clean Checkout') ...[
                        Container(
                          margin: const EdgeInsets.only(right: 4, top: 4),
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                              color: greenColor, shape: BoxShape.circle),
                        ),
                        5.pw,
                      ],
                    for (var i = 0; i < widget.report!.length; i++)
                      if (widget.report![i] == 'Clean Again')
                        const Icon(
                          Icons.sync_problem,
                          color: redColor,
                          size: 20,
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
                  onPressed: () => Get.back(),
                ),
                middle: Text("Room No: ${widget.title}"),
              ),
            ),
            if (!reportIsEmpty) 10.ph,
            if (!reportIsEmpty)
              const Text("Room Alerts")
                  .setStyle(size: 18, weight: FontWeight.w600),
            if (reportIsEmpty)
              const Text("No Room Report Available")
                  .setStyle(size: 16, weight: FontWeight.w500)
                  .paddingSymmetric(vertical: 10),
            if (widget.status.toString() == "Cleaned")
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
            if (widget.status.toString() == "Damaged")
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
            for (var i = 0; i < widget.report!.length; i++)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.report![i],
                        style: Get.textTheme.titleMedium,
                      ).setStyle(size: 14, weight: FontWeight.w500),
                      ...getNotificationIcon(widget.report![i]),
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
