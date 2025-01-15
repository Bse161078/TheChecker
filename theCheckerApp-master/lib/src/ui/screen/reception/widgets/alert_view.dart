import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widget/tap_widget.dart';

/// Created by amir on 10, December, 2022

class AlertView extends StatelessWidget {
  final VoidCallback onTap;
  const AlertView({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        width: Get.width > 800 ? 150 : 120,
        decoration: BoxDecoration(color: Get.theme.cardColor, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: redColor,
              size: 22,
            ),
            8.pw,
            Expanded(
              child: Text(
                'send_alert'.tr,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ).paddingSymmetric(vertical: 6),
      ),
    );
  }
}
