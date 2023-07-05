import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/cleaner_model.dart';
import '../../../routes/app_pages.dart';
import '../../../storage/pref.dart';
import '../../../utils/widgets/cached_image.dart';
import '../../widget/tap_widget.dart';
import '../../../controllers/checklist_controller.dart';
import "../../../utils/utils.dart";
import 'widgets/menu_item.dart';

import 'package:checkerapp/src/network/routes.dart' as Route;

class CheckMenu extends GetView<CheckListController> {
  final Cleaner cleaner;
  const CheckMenu({Key? key, required this.cleaner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CheckListController>(builder: (_) {
      _.isLoading;
      return Container(
        decoration: BoxDecoration(
          color: Get.theme.splashColor,
          border: Border(
            right: BorderSide(width: .4, color: Get.theme.dividerColor),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('checklist'.tr).setStyle(
              size: 20,
              color: Get.theme.primaryColor,
              weight: FontWeight.bold,
            ),
            16.ph,
            Stack(
              children: [
                AnimatedPositioned(
                  left: 0,
                  right: 0,
                  top: calcIndicatorTop(),
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    width: 130,
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 13),
                    decoration: BoxDecoration(
                      color: Get.theme.cardColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MenuItemView(
                        label: 'floor',
                        image: 'm_floor',
                        onTap: () {
                          CheckListController.to.currentCheckItem.value =
                              CheckMenuItems.floor;
                        },
                        isEnabled:
                            CheckListController.to.currentCheckItem.value ==
                                CheckMenuItems.floor),
                    MenuItemView(
                        label: 'bed',
                        image: 'm_bed',
                        onTap: () {
                          CheckListController.to.currentCheckItem.value =
                              CheckMenuItems.bed;
                        },
                        isEnabled:
                            CheckListController.to.currentCheckItem.value ==
                                CheckMenuItems.bed),
                    MenuItemView(
                        label: 'shelves',
                        image: 'm_shelves',
                        onTap: () {
                          CheckListController.to.currentCheckItem.value =
                              CheckMenuItems.shelves;
                        },
                        isEnabled:
                            CheckListController.to.currentCheckItem.value ==
                                CheckMenuItems.shelves),
                    MenuItemView(
                        label: 'Curtains',
                        image: 'm_curtains',
                        onTap: () {
                          CheckListController.to.currentCheckItem.value =
                              CheckMenuItems.curtains;
                        },
                        isEnabled:
                            CheckListController.to.currentCheckItem.value ==
                                CheckMenuItems.curtains),
                    MenuItemView(
                        label: 'bathroom',
                        image: 'm_bathroom',
                        onTap: () {
                          CheckListController.to.currentCheckItem.value =
                              CheckMenuItems.bathroom;
                        },
                        isEnabled:
                            CheckListController.to.currentCheckItem.value ==
                                CheckMenuItems.bathroom),
                  ],
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'checker_profile'.tr.toUpperCase(),
                  style: Get.textTheme.titleMedium,
                ).setStyle(size: 13, weight: FontWeight.bold),
                4.ph,
                Tap(
                  onTap: () =>
                      Get.offNamedUntil(Routes.DASHBOARD, (route) => false),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Get.theme.primaryColor,
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xff86c029),
                          Color(0xff1ebccf),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12, // Image radius
                              child: CircleAvatar(
                                radius: 11,
                                child: ClipOval(
                                  child: FutureBuilder(
                                      future: Utils.getValidatedNetworkImageWidget(
                                          "${Route.Routes.baseURL}/${Pref.to.userAvatarVal}",
                                          const CircleAvatar(
                                            radius: 80,
                                            child: Icon(Icons.person),
                                          )),
                                      builder: (context, snapshot) {
                                        return snapshot.hasData == true
                                            ? snapshot.data as Widget
                                            : const CircularProgressIndicator();
                                      }),
                                  // CachedImageWidget(
                                  //   image:
                                  //       "${Route.Routes.baseURL}/${Pref.to.userAvatarVal}",
                                  //   errorWidget: (context, url, error) =>
                                  //       const CircleAvatar(
                                  //     radius: 70,
                                  //     child: Icon(Icons.person),
                                  //   ),
                                  // ),
                                ),
                              ),
                            ),
                            8.pw,
                            Text(
                              Pref.to.nameVal,
                              style: Get.textTheme.titleMedium,
                            ).setStyle(weight: FontWeight.w600),
                          ],
                        ).paddingOnly(left: 8, top: 6, bottom: 6),
                        Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Get.theme.highlightColor,
                        ).paddingOnly(right: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            8.ph,
          ],
        ).paddingOnly(left: 22, top: 22, right: 22, bottom: 8),
      );
    });
  }

  double calcIndicatorTop() {
    double index = 0;
    switch (controller.currentCheckItem.value) {
      case CheckMenuItems.floor:
        index = 0;
        break;
      case CheckMenuItems.bed:
        index = 1;
        break;
      case CheckMenuItems.shelves:
        index = 2;
        break;
      case CheckMenuItems.curtains:
        index = 3;
        break;
      case CheckMenuItems.bathroom:
        index = 4;
        break;
    }
    return (index * 50) + index;
  }
}
