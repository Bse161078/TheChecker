import 'dart:io';

import 'package:checkerapp/src/controllers/checklist_controller.dart';
import 'package:checkerapp/src/ui/widget/answer_yes_no_widget.dart';
import 'package:checkerapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../widget/tap_widget.dart';
import 'widgets/add_photos_view.dart';

class ShelvesSection extends GetView<CheckListController> {
  TextEditingController controllerReport = TextEditingController();

  ShelvesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CheckListController>(initState: (_) {
      controllerReport.text = controller.shelvesDamageReport.value;
    }, builder: (_) {
      if (controllerReport.text.isEmpty) {
        controllerReport.text = controller.shelvesDamageReport.value;
      }
      _.isLoading;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'shelves'.tr,
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
                          'all_shelves_wiped'.tr,
                          style: Get.textTheme.titleMedium,
                        ).setStyle(size: 16),
                        10.ph,
                        AnswerYesNoWidget(
                            state: controller.shelvesAllShelvesWiped.value,
                            onChangeValue: (newState) => controller
                                .shelvesAllShelvesWiped.value = newState)
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
                    _.shelvesAllShelvesWipedPhoto.add(photo.path);
                  },
                  child: Container(
                    child: _.shelvesAllShelvesWipedPhoto.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(_.shelvesAllShelvesWipedPhoto.last),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'table'.tr,
                            style: Get.textTheme.titleMedium,
                          ).setStyle(size: 16),
                          10.ph,
                          AnswerYesNoWidget(
                              state: controller.shelvesTable.value,
                              onChangeValue: (newState) =>
                                  controller.shelvesTable.value = newState)
                        ],
                      ).paddingOnly(left: 16, bottom: 8),
                      // Checker(label: 'table'.tr, state: controller.shelvesTable.value, type: CheckerType.Check, onChanged: (newValue)=>controller.shelvesTable.value = newValue,),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.shelvesTablePhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.shelvesTablePhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
                  const Divider(
                    height: 4,
                  ).paddingSymmetric(horizontal: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'side_table'.tr,
                            style: Get.textTheme.titleMedium,
                          ).setStyle(size: 16),
                          10.ph,
                          AnswerYesNoWidget(
                              state: controller.shelvesSideTable.value,
                              onChangeValue: (newState) =>
                                  controller.shelvesSideTable.value = newState)
                        ],
                      ).paddingOnly(left: 16, bottom: 8),
                      // Checker(label: 'side_table'.tr, state: controller.shelvesSideTable.value, type: CheckerType.Check, onChanged: (newValue)=>controller.shelvesSideTable.value = newValue),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.shelvesSideTablePhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.shelvesSideTablePhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
                  const Divider(
                    height: 4,
                  ).paddingSymmetric(horizontal: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'tv'.tr,
                            style: Get.textTheme.titleMedium,
                          ).setStyle(size: 16),
                          10.ph,
                          AnswerYesNoWidget(
                              state: controller.shelvesTV.value,
                              onChangeValue: (newState) =>
                                  controller.shelvesTV.value = newState)
                        ],
                      ).paddingOnly(left: 16, bottom: 8),
                      // Checker(label: 'tv'.tr, state: controller.shelvesTV.value, type: CheckerType.Check, onChanged: (newValue)=>controller.shelvesTV.value = newValue),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.shelvesTVPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.shelvesTVPhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
                  const Divider(
                    height: 4,
                  ).paddingSymmetric(horizontal: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'window_sill'.tr,
                            style: Get.textTheme.titleMedium,
                          ).setStyle(size: 16),
                          10.ph,
                          AnswerYesNoWidget(
                              state: controller.shelvesWindowSill.value,
                              onChangeValue: (newState) =>
                                  controller.shelvesWindowSill.value = newState)
                        ],
                      ).paddingOnly(left: 16, bottom: 8),
                      // Checker(label: 'window_sill'.tr, state: controller.shelvesWindowSill.value, type: CheckerType.Check, onChanged: (newValue)=>controller.shelvesWindowSill.value = newValue),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.shelvesWindowSillPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.shelvesWindowSillPhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
                  const Divider(
                    height: 4,
                  ).paddingSymmetric(horizontal: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'cabinet_surfaces'.tr,
                            style: Get.textTheme.titleMedium,
                          ).setStyle(size: 16),
                          10.ph,
                          AnswerYesNoWidget(
                              state: controller.shelvesCabinetSurfaces.value,
                              onChangeValue: (newState) => controller
                                  .shelvesCabinetSurfaces.value = newState)
                        ],
                      ).paddingOnly(left: 16, bottom: 8),
                      // Checker(label: 'cabinet_surfaces'.tr, state: controller.shelvesCabinetSurfaces.value, type: CheckerType.Check, onChanged: (newValue)=>controller.shelvesCabinetSurfaces.value = newValue),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.shelvesCabinetSurfacesPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.shelvesCabinetSurfacesPhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
                  const Divider(
                    height: 4,
                  ).paddingSymmetric(horizontal: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 280,
                            child: Text(
                              'all_brochures_neatly_sorted'.tr,
                              style: Get.textTheme.titleMedium,
                            ).setStyle(size: 16),
                          ),
                          10.ph,
                          AnswerYesNoWidget(
                              state: controller
                                  .shelvesAllBrochuresNeatlySorted.value,
                              onChangeValue: (newState) => controller
                                  .shelvesAllBrochuresNeatlySorted
                                  .value = newState)
                        ],
                      ).paddingOnly(left: 16, bottom: 8),
                      // Checker(label: 'all_brochures_neatly_sorted'.tr, state: controller.shelvesAllBrochuresNeatlySorted.value, type: CheckerType.Check, onChanged: (newValue)=>controller.shelvesAllBrochuresNeatlySorted.value = newValue),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.shelvesAllBrochuresNeatlySortedPhoto
                                .add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.shelvesAllBrochuresNeatlySortedPhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
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
                    onChanged: (t) {
                      controller.shelvesDamageReport.value = t;
                    },
                    textAlign: TextAlign.left,
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
                          _.shelvesDamageReportPhoto.add(photoPath);
                          _.isLoading = true;
                          _.isLoading = false;
                        },
                        photos: _.shelvesDamageReportPhoto,
                      ),
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
