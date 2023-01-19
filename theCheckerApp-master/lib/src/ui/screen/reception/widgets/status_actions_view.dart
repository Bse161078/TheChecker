import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Created by amir on 10, December, 2022

enum StatusActions{
  free, occupied
}

class StatusActionsView extends StatelessWidget {
  final StatusActions state;
  const StatusActionsView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(24)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(state == StatusActions.free ? Icons.radio_button_off : Icons.circle, color: Get.theme.primaryColor, size: 22,),
                  8.pw,
                  Text(state == StatusActions.free ? 'free'.tr : 'occupied'.tr),
                ],
              ),
              Icon(Icons.keyboard_arrow_down_sharp, color: Get.theme.highlightColor, size: 22,),
            ],
          ).paddingSymmetric(vertical: 6),
        ),
      ],
    );
  }
}
