import 'package:checkerapp/src/utils/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart' as color;

class Btn extends StatelessWidget {

  final String label;
  final Function onPressed;
  final Color borderColor;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final bool isLoading;
  final bool enabled;
  final bool primaryBtn;
  final bool secondaryBtn;
  final IconData? iconData;
  final Color? iconColor;
  final TextDirection direction;
  final Color primaryColor;


  Btn({
    required this.label,
    required this.onPressed,
    this.borderColor = Colors.transparent,
    this.margin = EdgeInsets.zero,
    this.isLoading = false,
    this.enabled = true,
    this.secondaryBtn = false,
    this.iconData,
    this.iconColor,
    this.padding,
    this.direction = TextDirection.ltr,
    this.primaryColor = color.primaryColor,
    this.primaryBtn = true,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      color: borderColor,
      onPressed: ()=>onPressed(),
      child: Container(
        decoration: BoxDecoration(
          color: secondaryBtn ? Colors.transparent : enabled ? primaryColor : Get.theme.disabledColor, //Get.theme.disabledColor,
          borderRadius: BorderRadius.circular(6),
          // border: Border.all(width: 2, color: primaryColor),
          border: secondaryBtn ? Border.all(width: 2, color: primaryColor) : null,
          gradient: primaryBtn ? const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff86c029),
              Color(0xff1ebccf),
            ],
          ) : null,
        ),
        margin: margin,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading ? const SizedBox(width: 24, height: 24, child: CupertinoActivityIndicator()) :
            // isLoading ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: .9,)) :
            Directionality(
              textDirection: direction,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(iconData != null)
                    Icon(iconData, color: iconColor ?? Colors.white).paddingOnly(right: direction == TextDirection.ltr ? 6 : 0, left: direction == TextDirection.rtl ? 6 : 0) ,
                  Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(vertical: secondaryBtn ? 0 : 2),
      ),
    );
  }
}


