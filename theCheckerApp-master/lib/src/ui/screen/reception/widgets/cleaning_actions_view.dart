import 'package:checkerapp/src/ui/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Created by amir on 10, December, 2022

enum CleaningActions { cleaned, notCleaned, damaged, notAvailable, inProgress }

class CleaningActionsView extends StatelessWidget {
  final CleaningActions state;
  const CleaningActionsView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Get.width > 800 ? 150 : 120,
          decoration: BoxDecoration(
            color: getCleaningActionColor(state),
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(getCleaningActionText(state)).paddingOnly(left: 8),
              // Icon(Icons.keyboard_arrow_down_sharp, color: Get.theme.highlightColor, size: 22,),
            ],
          ).paddingSymmetric(vertical: 6),
        ).paddingOnly(left: 15),
      ],
    );
  }

  Color? getCleaningActionColor(CleaningActions state) {
    switch (state) {
      case CleaningActions.cleaned:
        return greenColor;
      case CleaningActions.notCleaned:
        return redColor;
      case CleaningActions.notAvailable:
        return redColor;
      case CleaningActions.damaged:
        return Colors.amber;
      case CleaningActions.inProgress:
        return Colors.amber;
    }
  }

  String getCleaningActionText(CleaningActions state) {
    switch (state) {
      case CleaningActions.cleaned:
        return 'cleaned'.tr;
      case CleaningActions.notCleaned:
        return 'not_cleaned'.tr;
      case CleaningActions.notAvailable:
        return "Not Available";
      case CleaningActions.damaged:
        return 'damaged'.tr;
      case CleaningActions.inProgress:
        return 'in_progress'.tr;
    }
  }
}
