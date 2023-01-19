
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
  const RoomBox({Key? key, this.onTap, required this.title, required this.type, required this.report, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        width: 140,
        height: 140,
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
                Text(title, style: Get.theme.textTheme.subtitle1,).setStyle(size: 22, weight: FontWeight.bold),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('suite'.toPng, width: 25, height: 15, fit: BoxFit.cover,),
                    2.ph,
                    Text(type, style: Get.theme.textTheme.subtitle1,).setStyle(weight: FontWeight.w600, size: 12),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  if(status.toString() == 'Cleaned') ... [
                    const Icon(Icons.check, color: greenColor,),
                    8.ph,
                  ] else if(status.toString() == 'Damaged') ... [
                    const Icon(Icons.close_rounded, color: redColor,),
                    8.ph,
                  ],

                  if(report.toString() == 'QuickClean') ... [
                    Icon(Icons.warning_amber_rounded, color: Get.theme.highlightColor,),
                  ] else if(report.toString() == 'ExtraBedNormal') ... [
                    Icon(Icons.bed, color: Get.theme.highlightColor,),
                  ] else if(report.toString() == 'ExtraBedChild') ... [
                    Icon(Icons.child_friendly, color: Get.theme.highlightColor,),
                  ] else if(report.toString() == 'RedCard') ... [
                    Container(
                      margin: const EdgeInsets.only(right: 4,top: 4),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: redColor,
                          shape: BoxShape.rectangle
                      ),
                    ),
                  ]else if(report.toString() == 'CleanStay') ... [
                    Container(
                      margin: const EdgeInsets.only(right: 4,top: 4),
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle
                      ),
                    ),
                  ]else if(report.toString() == 'CleanCheckOut') ... [
                    Container(
                      margin: const EdgeInsets.only(right: 4,top: 4),
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                          color: greenColor,
                          shape: BoxShape.circle
                      ),
                    ),
                  ]else if(report.toString() == 'CleanAgain') ... [
                    const Icon(Icons.sync_problem_rounded, color: redColor,),
                  ],

                  8.ph,

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
