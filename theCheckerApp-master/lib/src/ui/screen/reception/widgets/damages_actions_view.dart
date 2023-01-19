import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';

/// Created by amir on 10, December, 2022

enum DamagesActions{
  noDamages, damaged
}

class DamagesActionsView extends StatelessWidget {
  final DamagesActions state;
  const DamagesActionsView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(24)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  4.pw,
                  Icon(state == DamagesActions.noDamages ? Icons.thumb_up_off_alt_outlined : Icons.thumb_down_off_alt_rounded, color: state == DamagesActions.noDamages ? greenColor : redColor, size: 20,),
                  8.pw,
                  Text(state == DamagesActions.noDamages ? 'no_damages'.tr : 'damaged'.tr),
                ],
              ),
              // Icon(Icons.keyboard_arrow_down_sharp, color: Get.theme.highlightColor, size: 22,),
            ],
          ).paddingSymmetric(vertical: 6),
        ),
      ],
    );
  }
}
