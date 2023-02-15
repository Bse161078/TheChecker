import '../../../controllers/checklist_controller.dart';
import 'widgets/add_photos_view.dart';
import '../../widget/checker.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloorSection extends GetView<CheckListController> {
  TextEditingController controllerReport = TextEditingController();

  FloorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CheckListController>(initState: (_) {
      controllerReport.text = controller.floorDamageReport.value;
    }, builder: (_) {
      if (controllerReport.text.isEmpty) {
        controllerReport.text = controller.floorDamageReport.value;
      }

      _.isLoading;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'floor'.tr,
              style: Get.textTheme.titleMedium,
            ).setStyle(size: 18, weight: FontWeight.bold),
            16.ph,
            Row(
              children: [
                // Expanded(
                //   child: Container(
                //     height: 110,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       color: Get.theme.splashColor,
                //     ),
                //     padding: const EdgeInsets.all(16),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Text(
                //           'is_floor_vacuumed'.tr,
                //           style: Get.textTheme.titleMedium,
                //         ).setStyle(size: 16),
                //         10.ph,
                //         AnswerYesNoWidget(
                //             state: controller.floorRoomIsVacuumed.value,
                //             onChangeValue: (newState) =>
                //                 controller.floorRoomIsVacuumed.value = newState)
                //       ],
                //     ),
                //   ),
                // ),
                16.pw,
                // Tap(
                //   onTap: () async {
                //     final XFile? photo = await ImagePicker()
                //         .pickImage(source: ImageSource.gallery);
                //     if (photo == null) {
                //       return;
                //     }
                //     _.floorRoomIsVacuumedPhoto.add(photo.path);
                //   },
                //   child: Container(
                //     child: _.floorRoomIsVacuumedPhoto.isNotEmpty
                //         ? ClipRRect(
                //             borderRadius: BorderRadius.circular(8),
                //             child: Image.file(
                //               File(_.floorRoomIsVacuumedPhoto.last),
                //               width: 170,
                //               height: 110,
                //               fit: BoxFit.cover,
                //             ))
                //         : Container(
                //             width: 170,
                //             height: 110,
                //             decoration: BoxDecoration(
                //                 color: Get.theme.splashColor,
                //                 borderRadius: BorderRadius.circular(8)),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Icon(
                //                   Icons.photo,
                //                   color: Get.theme.primaryColor,
                //                   size: 30,
                //                 ),
                //                 8.ph,
                //                 Text('add_photos'.tr)
                //                     .setStyle(color: Colors.white, size: 16)
                //               ],
                //             ),
                //           ),
                //   ),
                // )
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // item 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checker(
                        label: 'room_not_vacuumed'.tr,
                        state: controller.floorRoomIsNotVacuumed.value,
                        type: CheckerType.Check,
                        onChanged: (newValue) =>
                            controller.floorRoomIsNotVacuumed.value = newValue,
                      ),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.floorRoomIsNotVacuumedPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.floorRoomIsNotVacuumedPhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
                  const Divider(
                    height: 4,
                  ).paddingSymmetric(horizontal: 12),

                  // item 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checker(
                        label: 'room_not_cleaned_by_us'.tr,
                        state: controller
                            .floorHasStrongStainsCanNotBeCleaned.value,
                        type: CheckerType.Check,
                        onChanged: (newValue) => controller
                            .floorHasStrongStainsCanNotBeCleaned
                            .value = newValue,
                      ),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.floorHasStrongStainsCanNotBeCleanedPhoto
                                .add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.floorHasStrongStainsCanNotBeCleanedPhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
                  const Divider(
                    height: 4,
                  ).paddingSymmetric(horizontal: 12),

                  // item 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checker(
                        label: 'damage_caused_by_guests'.tr,
                        state: controller.floorDamageCausedByGuests.value,
                        type: CheckerType.Check,
                        onChanged: (newValue) => controller
                            .floorDamageCausedByGuests.value = newValue,
                      ),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.floorDamageCausedByGuestsPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.floorDamageCausedByGuestsPhoto),
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
                      controller.floorDamageReport.value = t;
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
                            _.floorDamageReportPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.floorDamageReportPhoto),
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
