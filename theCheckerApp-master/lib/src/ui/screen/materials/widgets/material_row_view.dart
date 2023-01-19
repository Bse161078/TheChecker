import 'package:checkerapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/checker.dart';

/// Created by amir on 22, December, 2022

class MaterialRowView extends StatelessWidget {
  final bool isChecked;
  final String label;
  final Function onChangeState;
  final Function onChangeQty;
  const MaterialRowView({Key? key, required this.label, required this.isChecked, required this.onChangeState, required this.onChangeQty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checker(label: label.tr, state: isChecked, type: CheckerType.Check, onChanged: (newValue)=>onChangeState(newValue), longText: false),
          Container(decoration: BoxDecoration(
              color: Get.theme.backgroundColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Get.theme.dividerColor)
          ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('qty'.tr, style: Get.textTheme.subtitle1,).setStyle(size: 12),
                4.pw,
                SizedBox(
                  width: 50,
                  height: 36,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.right,
                    onChanged: (v)=>onChangeQty(v),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      counterText: "",
                      contentPadding: EdgeInsets.only(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 10,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 10),
          ).paddingOnly(right: 12),
        ],
      ).paddingOnly(top: 6, bottom: 4),
    );
  }
}
