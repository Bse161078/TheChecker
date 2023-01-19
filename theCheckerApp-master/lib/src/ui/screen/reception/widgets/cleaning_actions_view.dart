import 'package:checkerapp/src/ui/theme/app_colors.dart';

import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Created by amir on 10, December, 2022

enum CleaningActions{
  cleaned, notCleaned, damaged
}

class CleaningActionsView extends StatelessWidget {
  final CleaningActions state;
  const CleaningActionsView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          decoration: BoxDecoration(
              color: state == CleaningActions.cleaned ? greenColor : state == CleaningActions.notCleaned ? redColor : Colors.amber,
              borderRadius: BorderRadius.circular(24)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state == CleaningActions.cleaned ? 'cleaned'.tr : state == CleaningActions.notCleaned ? 'not_cleaned'.tr : 'damaged'.tr).paddingOnly(left: 8),
              // Icon(Icons.keyboard_arrow_down_sharp, color: Get.theme.highlightColor, size: 22,),
            ],
          ).paddingSymmetric(vertical: 6),
        ),
      ],
    );
  }
}
