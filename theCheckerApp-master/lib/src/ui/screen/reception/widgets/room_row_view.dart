import 'package:checkerapp/src/utils/ext/padding.dart';
import 'package:checkerapp/src/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'alert_view.dart';
import 'cleaning_actions_view.dart';
import 'damages_actions_view.dart';

/// Created by amir on 22, December, 2022

class RoomRowView extends StatelessWidget {
  final String label;
  final String type;
  final String cleaningStatus;
  final VoidCallback onTapAlert;
  const RoomRowView(
      {Key? key,
      required this.label,
      required this.type,
      required this.cleaningStatus,
      required this.onTapAlert})
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
                  // Checker(label: '$label', state: false, type: CheckerType.Check, onChanged: (newValue){}, fontSize: 20, longText: false),
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
}
