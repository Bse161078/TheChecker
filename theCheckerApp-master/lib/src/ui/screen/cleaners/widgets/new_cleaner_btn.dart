
import 'package:checkerapp/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';

class NewCleanerButton extends StatelessWidget {
  final VoidCallback onTap;
  const NewCleanerButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Get.theme.splashColor,
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 80, // Image radius
              backgroundColor: Color(0x330bbbef),
              child: Icon(Icons.add, color: primaryColor, size: 58,),
            ),
            8.ph,
            Text('new_cleaner'.tr, style: Get.theme.textTheme.subtitle1,).setStyle(size: 15, weight: FontWeight.w600),
          ],
        ),
      ),
    );
  }
}
