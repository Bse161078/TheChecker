// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:checkerapp/src/controllers/checklist_controller.dart';
import 'package:checkerapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../widget/answer_yes_no_widget.dart';
import '../../widget/checker.dart';
import '../../widget/tap_widget.dart';
import 'widgets/add_photos_view.dart';

class CurtainsSection extends GetView<CheckListController> {
  TextEditingController controllerReport = TextEditingController();

  CurtainsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CheckListController>(initState: (_) {
      controllerReport.text = controller.curtainsDamageReport.value;
    }, builder: (_) {
      if (controllerReport.text.isEmpty) {
        controllerReport.text = controller.curtainsDamageReport.value;
      }
      _.isLoading;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'curtains'.tr,
              style: Get.textTheme.titleMedium,
            ).setStyle(size: 18, weight: FontWeight.bold),
            16.ph,
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Get.theme.splashColor,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Are curtains clean?',
                          style: Get.textTheme.titleMedium,
                        ).setStyle(size: 16),
                        10.ph,
                        AnswerYesNoWidget(
                            state: controller.curtainsTopQuestion.value,
                            onChangeValue: (newState) =>
                                controller.curtainsTopQuestion.value = newState)
                      ],
                    ),
                  ),
                ),
                16.pw,
                Tap(
                  onTap: () async {
                    final XFile? photo = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (photo == null) {
                      return;
                    }
                    _.curtainsTopQuestionPhoto.add(photo.path);
                  },
                  child: Container(
                    child: _.curtainsTopQuestionPhoto.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(_.curtainsTopQuestionPhoto.last),
                              width: 170,
                              height: 110,
                              fit: BoxFit.cover,
                            ))
                        : Container(
                            width: 170,
                            height: 110,
                            decoration: BoxDecoration(
                                color: Get.theme.splashColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo,
                                  color: Get.theme.primaryColor,
                                  size: 30,
                                ),
                                8.ph,
                                Text('add_photos'.tr)
                                    .setStyle(color: Colors.white, size: 16)
                              ],
                            ),
                          ),
                  ),
                )
              ],
            ),
            22.ph,
            Text(
              'comments'.tr,
              style: Get.textTheme.titleMedium,
            ).setStyle(size: 14),
            8.ph,
            Container(
              // height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Get.theme.splashColor,
              ),
              // padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checker(
                        label: 'Curtains Are Not Clean'.tr,
                        state: controller.curtainsNotClean.value,
                        type: CheckerType.Check,
                        onChanged: (newValue) =>
                            controller.curtainsNotClean.value = newValue,
                      ),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.curtainsNotCleanPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.curtainsNotCleanPhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
                  const Divider(
                    height: 4,
                  ).paddingSymmetric(horizontal: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checker(
                        label: 'Curtains Have Wrinkles',
                        state: controller.curtainsHaveWrinkles.value,
                        type: CheckerType.Check,
                        onChanged: (newValue) =>
                            controller.curtainsHaveWrinkles.value = newValue,
                      ),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.curtainsHaveWrinklesPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.curtainsHaveWrinklesPhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
                  const Divider(
                    height: 4,
                  ).paddingSymmetric(horizontal: 12),
                ],
              ),
            ),
            22.ph,
            Text(
              'damage_report'.tr,
              style: Get.textTheme.titleMedium,
            ).setStyle(size: 14),
            8.ph,
            Container(
              // height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Get.theme.splashColor,
              ),
              // padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    textInputAction: TextInputAction.newline,
                    controller: controllerReport,
                    textAlign: TextAlign.left,
                    onChanged: (t) {
                      controller.curtainsDamageReport.value = t;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      counterText: "",
                      contentPadding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 12,
                        bottom: 0,
                      ),
                      hintText: 'enter_additional_report'.tr,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Get.theme.hintColor,
                          fontSize: 14),
                    ),
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    maxLength: 500,
                  ),
                  6.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.curtainsDamageReportPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.curtainsDamageReportPhoto),
                    ],
                  ),
                  6.ph,
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
