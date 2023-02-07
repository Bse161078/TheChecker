import '../../../routes/app_pages.dart';
import '../../widget/button_widget.dart';
import '../../../utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/cleaner_model.dart';
import '../../../data/model/room_model.dart';
import 'bathroom_section.dart';
import 'check_menu.dart';
import 'bed_section.dart';
import 'curtains_section.dart';
import 'shelves_section.dart';
import 'floor_section.dart';
import '../../../../src/controllers/checklist_controller.dart';

class CheckList extends GetView<CheckListController> {
  late Room room;
  late Cleaner cleaner;

  CheckList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CheckListController>(initState: (_) {
      room = Get.arguments[0];
      cleaner = Get.arguments[1];
    }, builder: (_) {
      _.isLoading;
      return Scaffold(
          appBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              previousPageTitle: 'cleaners'.tr,
              onPressed: () => Get.back(),
            ),
            middle: Text('${'room'.tr} ${room.name}'),
          ),
          body: Row(
            children: [
              // menu
              Expanded(
                flex: 2,
                child: CheckMenu(
                  cleaner: cleaner,
                ),
              ),

              // sections
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    _sections(),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (CheckListController
                                      .to.currentCheckItem.value !=
                                  CheckMenuItems.floor) ...[
                                Btn(
                                  label: 'back'.tr,
                                  onPressed: () => _backTap(),
                                  secondaryBtn: true,
                                  iconData: Icons.arrow_back_rounded,
                                  iconColor: Get.theme.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 7),
                                ),
                              ] else ...[
                                const SizedBox(),
                              ],

                              // if(CheckListController.to.currentCheckItem.value != CheckMenuItems.bathroom) ...[
                              Btn(
                                  label: 'save_next'.tr,
                                  onPressed: () => _nextTap(),
                                  isLoading: _.isLoading,
                                  iconData: Icons.arrow_back_rounded,
                                  direction: TextDirection.rtl,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 9)),
                              // ] else ...[
                              //   Btn(label: 'order_items'.tr, onPressed: ()=>Get.toNamed(Routes.CONTINUE_ORDER), iconData: Icons.shopping_bag_outlined,  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9)),
                              // ],
                            ],
                          ).paddingOnly(
                              left: 22, right: 22, bottom: 16, top: 8),
                        ).background(Get.theme.colorScheme.background))
                  ],
                ),
              ),
            ],
          ));
    });
  }

  Widget _sections() {
    switch (controller.currentCheckItem.value) {
      case CheckMenuItems.floor:
        return FloorSection();
      case CheckMenuItems.bed:
        return BedSection();
      case CheckMenuItems.shelves:
        return ShelvesSection();
      case CheckMenuItems.curtains:
        return CurtainsSection();
      case CheckMenuItems.bathroom:
        return BathroomSection();
    }
  }

  _nextTap() async {
    if (controller.isLoading) {
      return;
    }

    controller.isLoading = true;

    switch (controller.currentCheckItem.value) {
      case CheckMenuItems.floor:
        await controller.updateFloorItems(room.id);
        break;
      case CheckMenuItems.bed:
        await controller.updateBedItems(room.id);
        break;
      case CheckMenuItems.shelves:
        await controller.updateShelvesItems(room.id);
        break;
      case CheckMenuItems.curtains:
        await controller.updateCurtainsItems(room.id);
        break;
      case CheckMenuItems.bathroom:
        await controller.updateBathroomItems(room.id);
        Get.toNamed(Routes.CONTINUE_ORDER, arguments: [room, cleaner]);
        break;
    }

    controller.isLoading = false;

    if (controller.currentCheckItem.value != CheckMenuItems.bathroom) {
      controller.currentCheckItem.value =
          CheckMenuItems.values[controller.currentCheckItem.value.index + 1];
    }
  }

  _backTap() {
    controller.currentCheckItem.value =
        CheckMenuItems.values[controller.currentCheckItem.value.index - 1];
  }
}
