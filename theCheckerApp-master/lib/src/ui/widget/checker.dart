import '../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CheckerType { Check, Radio }

class Checker extends StatelessWidget {
  final String label;
  final bool state;
  final CheckerType type;
  final Function onChanged;
  final double fontSize;
  final bool longText;
  final bool hasBorder;

  const Checker(
      {Key? key,
      required this.label,
      required this.state,
      required this.type,
      required this.onChanged,
      this.fontSize = 14,
      this.longText = true,
      this.hasBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!state),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Get.theme.splashColor,
          border: (hasBorder && state)
              ? Border.all(color: Get.theme.primaryColor, width: 1.2)
              : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            if (type == CheckerType.Check) ...[
              Checkbox(
                checkColor: Get.theme.primaryColor,
                activeColor: Get.theme.cardColor,
                value: state,
                onChanged: (bool? newValue) => onChanged(newValue),
              ),
            ] else ...[
              InkWell(
                  onTap: () => onChanged(!state),
                  child: Icon(
                    state ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: state ? Get.theme.primaryColor : Get.theme.cardColor,
                  ).paddingSymmetric(vertical: 5)),
            ],
            8.pw,
            longText
                ? SizedBox(
                    width: Get.width / 3,
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                    ).setStyle(size: fontSize))
                : SizedBox(
                    width: 100,
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                    ).setStyle(size: fontSize),
                  ),
          ],
        ),
      ),
    );
  }
}
