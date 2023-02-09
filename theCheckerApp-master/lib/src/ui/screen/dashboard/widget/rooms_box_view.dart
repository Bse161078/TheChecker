import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/button_widget.dart';

/// Created by amir on 02, December, 2022

class RoomsBoxView extends StatelessWidget {
  final VoidCallback onTap;
  final String roomsNo;

  const RoomsBoxView({Key? key, required this.onTap, required this.roomsNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Get.theme.splashColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'rooms'.tr,
                style: Get.theme.textTheme.titleMedium,
              ).setStyle(weight: FontWeight.w600, size: 14),
              Image.asset(
                'double_bed'.toPng,
                width: 25,
                height: 15,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Text(
            roomsNo,
            style: Get.theme.textTheme.titleMedium,
          ).setStyle(size: 24, weight: FontWeight.bold),
          22.ph,
          Btn(
            label: 'start_checking'.tr,
            onPressed: onTap,
            iconData: Icons.arrow_back_rounded,
            direction: TextDirection.rtl,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 9,
            ),
          ),
        ],
      ),
    );
  }
}
