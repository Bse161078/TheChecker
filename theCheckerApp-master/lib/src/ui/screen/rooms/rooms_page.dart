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

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  TextEditingController controllerSearchBox = TextEditingController();

  RoomsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX<RoomsController>(
      initState: (_) {
        controller.getRooms();
        controller.filteredRooms = controller.roomsList;
        controller.filteredLevelsList = controller.levelsList;
      },
      builder: (roomsController) {
        print("Rebuilding Rooms Page");
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
                        setState(() {
                          controller.searchRooms(controllerSearchBox.text);
                        });
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
                        for (int i = 0;
                            i < controller.filteredLevelsList.length;
                            i++)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: Get.width / 2,
                                    child: Text(
                                      'Level  ${controller.filteredLevelsList[i].level?.title}',
                                      overflow: TextOverflow.ellipsis,
                                    ).setStyle(size: 17),
                                  ),
                                ],
                              ).paddingOnly(left: 16),
                              CustomPaint(
                                  painter: DashedLinePainter(),
                                  size: Size(Get.width - 32, 1.5)),
                              12.ph,
                              roomsListView(
                                controller.filteredLevelsList[i].level?.id,
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
    List<Room> list = controller.filteredRooms
        .where((p0) => p0.level?.id == levelId)
        .toList();
    return SizedBox(
      height: 200,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          Room room = list[index];
          return RoomBox(
            onTap: () {
              Get.toNamed(Routes.CLEANERS, arguments: room);
            },
            title: '${room.name}',
            type: '${room.roomType}'.tr,
            status: room.status ?? '',
            report: room.report ?? [],
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
        width: Get.width / 1.8,
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
                      onTap: () {
                        setState(() {
                          controller.resetFilters();
                        });
                        Get.back();
                      },
                      child: Text('reset'.tr).setStyle(color: Colors.red),
                    ),
                    middle: Text('filter_rooms'.tr),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Room Type'.tr,
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
                          state: controller.roomTypesChecks[i].value,
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
                            state: controller.roomTypesChecks[i + 1].value,
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
                    onPressed: () {
                      setState(() {
                        controller.applyFilters();
                      });
                      Get.back();
                    },
                  ),
                ),
                24.ph,
              ],
            )),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}
