import 'package:checkerapp/src/ui/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../src/utils/utils.dart';

class RoomBox extends StatelessWidget {
  final String title;
  final String type;
  final String report;
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
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        width: 160,
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
                  title,
                  style: Get.theme.textTheme.titleMedium,
                ).setStyle(size: 22, weight: FontWeight.bold),
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
                      type,
                      style: Get.theme.textTheme.titleMedium,
                    ).setStyle(weight: FontWeight.w600, size: 12),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (status.toString() == 'Cleaned') ...[
                    const Icon(
                      Icons.check,
                      color: greenColor,
                    ),
                    8.ph,
                  ] else if (status.toString() == 'Damaged') ...[
                    const Icon(
                      Icons.close_rounded,
                      color: redColor,
                    ),
                    8.ph,
                  ],
                  if (report.toString() == 'QuickClean') ...[
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Get.theme.highlightColor,
                    ),
                  ] else if (report.toString() == 'ExtraBedNormal') ...[
                    Icon(
                      Icons.bed,
                      color: Get.theme.highlightColor,
                    ),
                  ] else if (report.toString() == 'ExtraBedChild') ...[
                    Icon(
                      Icons.child_friendly,
                      color: Get.theme.highlightColor,
                    ),
                  ] else if (report.toString() == 'RedCard') ...[
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
                  ] else if (report.toString() == 'CleanStay') ...[
                    Container(
                      margin: const EdgeInsets.only(right: 4, top: 4),
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                          color: Colors.amber, shape: BoxShape.circle),
                    ),
                  ] else if (report.toString() == 'CleanCheckOut') ...[
                    Container(
                      margin: const EdgeInsets.only(right: 4, top: 4),
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                          color: greenColor, shape: BoxShape.circle),
                    ),
                  ] else if (report.toString() == 'CleanAgain') ...[
                    const Icon(
                      Icons.sync_problem_rounded,
                      color: redColor,
                    ),
                  ],
                  8.ph,
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  print('info icon button tapped');
                  showRoomInfoDialog(context);
                },
                child: const SizedBox(
                  child: Icon(
                    Icons.info_outline_rounded,
                  ),
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
                middle: Text("Room No: $title"),
              ),
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Get.theme.highlightColor,
                ),
                Text(
                  "Quick Clean",
                  style: Get.textTheme.titleMedium,
                ).setStyle(size: 14, weight: FontWeight.w500)
              ],
            ).paddingOnly(right: 20, left: 20, bottom: 20),
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
