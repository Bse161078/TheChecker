import 'package:checkerapp/src/ui/widget/tap_widget.dart';
import 'package:checkerapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItemView extends StatelessWidget {
  final String label;
  final String image;
  final bool isEnabled;
  final VoidCallback onTap;
  const MenuItemView(
      {Key? key,
      required this.label,
      required this.image,
      required this.onTap,
      required this.isEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
        decoration: BoxDecoration(
            color: Colors.transparent,
            // color: isEnabled ? Get.theme.cardColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8)),
        // duration: const Duration(milliseconds: 300),
        // curve: Curves.fastOutSlowIn,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image.toPng,
              width: 20,
            ),
            16.pw,
            Text(
              label.tr,
              style: Get.textTheme.titleMedium,
            ).setStyle(size: 16, weight: FontWeight.w500),
          ],
        ),
      ),
    );
  }
}
