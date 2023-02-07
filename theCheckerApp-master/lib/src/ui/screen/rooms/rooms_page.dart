import '../../../data/model/room_model.dart';
import '../../widget/checker.dart';
import '../../../../src/ui/screen/rooms/widgets/room_box.dart';
import '../../../../src/ui/widget/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import '../../../../src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/rooms_controller.dart';
import '../../../routes/app_pages.dart';
import '../../widget/button_widget.dart';
import '../../widget/tap_widget.dart';
import 'widgets/dashline.dart';

class Rooms extends GetView<RoomsController> {
  TextEditingController controllerSearchBox = TextEditingController();
  List<Room> filteredRooms = [];
  List<Room> filteredLevelsList = [];

  Rooms({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<RoomsController>(
      initState: (_) {
        controller.getRooms();
        filteredRooms = controller.roomsList;
        filteredLevelsList = controller.levelsList;
      },
      builder: (roomsController) {
        roomsController.isLoading;

        return Scaffold(
          appBar: CupertinoNavigationBar(
            middle: Text('rooms'.tr),
            leading: CupertinoNavigationBarBackButton(
              previousPageTitle: 'home'.tr,
              onPressed: () => Get.back(),
            ),
          ),
          body: Column(
            children: [
              18.ph,

              // search bar
              Row(
                children: [
                  Flexible(
                      child: TxtField(
                    controller: controllerSearchBox,
                    label: 'search_room'.tr,
                    hasSearchIcon: true,
                  )),
                  8.pw,
                  SizedBox(
                    width: 130,
                    height: 47,
                    child: Btn(
                      label: 'filter'.tr,
                      secondaryBtn: true,
                      onPressed: () => _showFilterDialog(context),
                    ),
                  ),
                  8.pw,
                  SizedBox(
                    width: 130,
                    height: 47,
                    child: Btn(
                      label: 'search'.tr,
                      onPressed: () {
                        filteredRooms = controller.roomsList
                            .where((room) => room.name!.toLowerCase().contains(
                                controllerSearchBox.text.toLowerCase()))
                            .toList();
                        var set = <String?>{};
                        filteredLevelsList = filteredRooms
                            .where((element) => set.add(element.level?.id))
                            .toList();

                        controller.update();
                      },
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),

              16.ph,

              if (roomsController.isLoading) ...[
                const Expanded(
                    child: Center(
                        child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CupertinoActivityIndicator())))
              ] else ...[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < filteredLevelsList.length; i++)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text('${filteredLevelsList[i].level?.title}')
                                      .setStyle(size: 17),
                                ],
                              ).paddingOnly(left: 16),
                              CustomPaint(
                                  painter: DashedLinePainter(),
                                  size: Size(Get.width - 32, 1.5)),
                              12.ph,
                              roomsListView(
                                filteredLevelsList[i].level?.id,
                              ),
                              20.ph,
                            ],
                          ),
                      ],
                    ),
                  ),
                )
              ]
            ],
          ),
        );
      },
    );
  }

  Widget roomsListView(levelId) {
    List<Room> list =
        filteredRooms.where((p0) => p0.level?.id == levelId).toList();
    return SizedBox(
      height: 125,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          Room room = list[index];
          return RoomBox(
            onTap: () => Get.toNamed(Routes.CLEANERS, arguments: room),
            title: '${room.name}',
            type: '${room.roomType?.title}'.tr,
            status: room.status ?? '',
            report: room.report ?? '',
          );
        },
      ).paddingOnly(left: 16),
    );
  }

  void _showFilterDialog(BuildContext context) {
    controller.roomTypesList = RxList<String>([]);
    controller.getRoomTypes();

    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SizedBox(
        width: Get.width / 2.2,
        child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12)),
                  child: CupertinoNavigationBar(
                    leading: CupertinoNavigationBarBackButton(
                      previousPageTitle: 'cancel'.tr,
                      onPressed: () => Get.back(),
                    ),
                    trailing: Tap(
                      onTap: () => Get.back(),
                      child: Text('reset'.tr).setStyle(color: Colors.red),
                    ),
                    middle: Text('filter_rooms'.tr),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'bed_type'.tr,
                      style: Get.textTheme.titleMedium,
                    )
                        .setStyle(size: 14, weight: FontWeight.w500)
                        .paddingOnly(left: 24, top: 24),
                  ],
                ),
                8.ph,
                for (int i = 0; i < controller.roomTypesList.length; i += 2)
                  Row(
                    children: [
                      Expanded(
                        child: Checker(
                          label: controller.roomTypesList[i],
                          state: controller.singleBedCheck.value,
                          type: CheckerType.Check,
                          onChanged: (newValue) =>
                              {controller.roomTypesChecks[i].value = newValue},
                          longText: false,
                        ),
                      ),
                      16.pw,
                      if (i + 1 < controller.roomTypesList.length)
                        Expanded(
                          child: Checker(
                            label: controller.roomTypesList[i + 1],
                            state: controller.doubleBedCheck.value,
                            type: CheckerType.Check,
                            onChanged: (newValue) => {
                              controller.roomTypesChecks[i + 1].value = newValue
                            },
                            longText: false,
                          ),
                        ),
                    ],
                  ).paddingSymmetric(horizontal: 24, vertical: 12),
                Row(
                  children: [
                    Text(
                      'status'.tr,
                      style: Get.textTheme.titleMedium,
                    )
                        .setStyle(size: 14, weight: FontWeight.w500)
                        .paddingOnly(left: 24, top: 24),
                  ],
                ),
                8.ph,
                Row(
                  children: [
                    Expanded(
                      child: Checker(
                          label: 'free'.tr,
                          state: controller.freeCheck.value,
                          type: CheckerType.Check,
                          onChanged: (newValue) =>
                              controller.freeCheck.value = newValue,
                          longText: false),
                    ),
                    16.pw,
                    Expanded(
                      child: Checker(
                          label: 'occupied'.tr,
                          state: controller.occupiedCheck.value,
                          type: CheckerType.Check,
                          onChanged: (newValue) =>
                              controller.occupiedCheck.value = newValue,
                          longText: false),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 24),
                Row(
                  children: [
                    Text(
                      'cleaning'.tr,
                      style: Get.textTheme.titleMedium,
                    )
                        .setStyle(size: 14, weight: FontWeight.w500)
                        .paddingOnly(left: 24, top: 24),
                  ],
                ),
                8.ph,
                Row(
                  children: [
                    Expanded(
                      child: Checker(
                          label: 'not_cleaned'.tr,
                          state: controller.notCleanedCheck.value,
                          type: CheckerType.Check,
                          onChanged: (newValue) =>
                              controller.notCleanedCheck.value = newValue,
                          longText: false),
                    ),
                    16.pw,
                    Expanded(
                      child: Checker(
                          label: 'in_progress'.tr,
                          state: controller.inProgressCheck.value,
                          type: CheckerType.Check,
                          onChanged: (newValue) =>
                              controller.inProgressCheck.value = newValue,
                          longText: false),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 24),
                12.ph,
                Row(
                  children: [
                    Expanded(
                      child: Checker(
                          label: 'cleaned'.tr,
                          state: controller.cleanedCheck.value,
                          type: CheckerType.Check,
                          onChanged: (newValue) =>
                              controller.cleanedCheck.value = newValue,
                          longText: false),
                    ),
                    16.pw,
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 24),
                42.ph,
                SizedBox(
                    width: Get.width / 4.8,
                    child: Btn(
                        label: 'apply_filters'.tr,
                        onPressed: () => Get.back())),
                24.ph,
              ],
            )),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}
