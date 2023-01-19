

import 'package:checkerapp/src/controllers/checklist_controller.dart';
import 'package:checkerapp/src/ui/widget/textfield_widget.dart';
import 'package:checkerapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../widget/button_widget.dart';
import '../../widget/checker.dart';
import '../cleaners/widgets/cleaner_avatar.dart';

class MaterialsSection extends GetView<CheckListController>{

  @override
  Widget build(BuildContext context) {
    return GetX<CheckListController>(
        initState: (_){

        },
        builder: (_) {
          _.isLoading;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('materials_list'.tr, style: Get.textTheme.subtitle1,).setStyle(size: 18, weight: FontWeight.bold),
                22.ph,
                Text('room_items'.tr, style: Get.textTheme.subtitle1,).setStyle(size: 14),
                8.ph,

                Container(
                  // height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Get.theme.splashColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checker(label: 'Chips'.tr, state: controller.materialChips.value, type: CheckerType.Check, onChanged: (newValue)=>controller.materialChips.value = newValue, longText: false),
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
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            counterText: "",
                                            contentPadding: const EdgeInsets.only(
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
                          ),
                          8.pw,
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checker(label: 'water'.tr, state: controller.materialWater.value, type: CheckerType.Check, onChanged: (newValue)=>controller.materialWater.value = newValue, longText: false),
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
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            counterText: "",
                                            contentPadding: const EdgeInsets.only(
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
                          ),

                        ],
                      ),



                      // const Divider(height: 4,).paddingSymmetric(horizontal: 12),


                    ],
                  ),
                ),

                68.ph,
              ],
            ).paddingOnly(left: 22, right: 22, top: 22),
          );
        });
  }

}