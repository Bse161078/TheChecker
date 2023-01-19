import '../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'button_widget.dart';

/// Created by amir on 10, December, 2022
class AnswerYesNoWidget extends StatelessWidget {
  final bool state;
  final Function onChangeValue;
  const AnswerYesNoWidget({Key? key, required this.state, required this.onChangeValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 100, child: Btn(label: 'yes'.tr, primaryBtn: false, secondaryBtn: state != true, onPressed: ()=>onChangeValue(true), primaryColor: state ? const Color(0xff27AE60) : Get.theme.highlightColor, iconData: Icons.thumb_up_alt_rounded, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8))),
        10.pw,
        SizedBox(width: 100, child: Btn(label: 'no'.tr, primaryBtn: false, secondaryBtn: state != false, onPressed: ()=>onChangeValue(false), primaryColor: !state ? const Color(0xffEB5757) : Get.theme.highlightColor, iconData: Icons.thumb_down_sharp, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),)),
      ],
    );
  }
}
