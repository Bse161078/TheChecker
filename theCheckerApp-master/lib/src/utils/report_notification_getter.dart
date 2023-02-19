import 'package:checkerapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/theme/app_colors.dart';

List<Widget> getNotificationIcon(String reportString) {
  switch (reportString) {
    case "Red Card":
      return [
        10.pw,
        Container(
          margin: const EdgeInsets.only(right: 4, top: 4, left: 4),
          width: 13,
          height: 13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: redColor,
            shape: BoxShape.rectangle,
          ),
        ),
      ];

    case "Clean Stay":
      return [
        10.pw,
        Container(
          margin: const EdgeInsets.only(right: 4, top: 4),
          width: 14,
          height: 14,
          decoration:
              const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
        ),
      ];
    case "Clean Checkout":
      return [
        10.pw,
        Container(
          margin: const EdgeInsets.only(right: 4, top: 4),
          width: 14,
          height: 14,
          decoration:
              const BoxDecoration(color: greenColor, shape: BoxShape.circle),
        ),
      ];
    case "Clean Again":
      return [
        10.pw,
        const Icon(
          Icons.sync_problem,
          color: redColor,
          size: 20,
        ),
      ];
    case "Extra Bed Child":
      return [
        10.pw,
        Icon(
          Icons.child_friendly,
          color: Get.theme.highlightColor,
        ),
      ];
    case "Extra Bed Normal":
      return [
        10.pw,
        Icon(
          Icons.bed,
          color: Get.theme.highlightColor,
        ),
      ];
    case "Clean Quick Guest Waiting":
      return [
        10.pw,
        Icon(
          Icons.warning_amber_rounded,
          color: Get.theme.highlightColor,
        ),
      ];
    default:
      return [Container()];
  }
}
