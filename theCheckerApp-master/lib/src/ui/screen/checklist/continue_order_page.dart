// ignore_for_file: non_constant_identifier_names

import 'package:checkerapp/src/controllers/rooms_controller.dart';

import '../../../data/repository/main_repository.dart';
import '../../../network/response.dart';
import '../../../routes/app_pages.dart';
import '../../theme/app_colors.dart';
import '../../widget/button_widget.dart';
import '../../../utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/tap_widget.dart';

class ContinueOrder extends StatefulWidget {
  const ContinueOrder({Key? key}) : super(key: key);

  @override
  State<ContinueOrder> createState() => _ContinueOrderState();
}

class _ContinueOrderState extends State<ContinueOrder> {
  bool cleaned = false;
  bool notCleaned = false;
  bool damaged = false;

  bool isLoading = false;
  var roomId = '';
  var occupation_status = "";
  var cleanerId = "";
  var status = "";

  @override
  void initState() {
    super.initState();
    log(this, 'roomid ${Get.arguments}');
    roomId = Get.arguments[0].id;
    occupation_status = Get.arguments[0].occupation_status;
    cleanerId = Get.arguments[1].id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
          leading: CupertinoNavigationBarBackButton(
            previousPageTitle: 'Check List'.tr,
            onPressed: () {
              Get.back();
            },
          ),
          middle: Text('Continue'.tr),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'pls_make_appropriate_selection'.tr,
              style: Get.textTheme.titleMedium,
            ).setStyle(size: 20).paddingOnly(left: 24, top: 24),
            34.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tap(
                  onTap: () {
                    setState(() {
                      cleaned = true;
                      notCleaned = false;
                      damaged = false;
                    });
                  },
                  child: Container(
                    height: 215,
                    width: Get.width / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Get.theme.splashColor,
                      border: cleaned
                          ? Border.all(
                              color: Get.theme.primaryColor, width: 1.2)
                          : null,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          6.ph,
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            size: 38,
                            color: greenColor,
                          ),
                          18.ph,
                          SizedBox(
                              width: Get.width / 5.2,
                              child: Text(
                                'room_release_all_defects'.tr,
                                style: Get.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ).paddingSymmetric(horizontal: 4)),
                          22.ph,
                        ],
                      ),
                    ),
                  ),
                ),
                22.pw,
                Tap(
                  onTap: () {
                    setState(() {
                      cleaned = false;
                      notCleaned = true;
                      damaged = false;
                    });
                  },
                  child: Container(
                    height: 215,
                    width: Get.width / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Get.theme.splashColor,
                      border: notCleaned
                          ? Border.all(
                              color: Get.theme.primaryColor, width: 1.2)
                          : null,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        6.ph,
                        const Icon(
                          Icons.info_outlined,
                          size: 38,
                          color: Colors.amber,
                        ),
                        18.ph,
                        SizedBox(
                            width: Get.width / 5.2,
                            child: Text(
                              'room_not_cleaned'.tr,
                              style: Get.textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ).paddingSymmetric(horizontal: 4)),
                        22.ph,
                      ],
                    ),
                  ),
                ),
                22.pw,
                Tap(
                  onTap: () {
                    setState(() {
                      cleaned = false;
                      notCleaned = false;
                      damaged = true;
                    });
                  },
                  child: Container(
                    height: 215,
                    width: Get.width / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Get.theme.splashColor,
                      border: damaged
                          ? Border.all(
                              color: Get.theme.primaryColor, width: 1.2)
                          : null,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          6.ph,
                          const Icon(
                            Icons.warning_amber_rounded,
                            size: 38,
                            color: redColor,
                          ),
                          18.ph,
                          SizedBox(
                              width: Get.width / 5.2,
                              child: Text(
                                'room_was_cleaned_but_not_released_due_damage'
                                    .tr,
                                style: Get.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ).paddingSymmetric(horizontal: 4)),
                          22.ph,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            44.ph,
            SizedBox(
              width: Get.width / 5,
              child: Btn(
                label: 'continue'.tr,
                onPressed: () => setRoomStatus(),
                isLoading: isLoading,
                iconData: Icons.arrow_back_rounded,
                direction: TextDirection.rtl,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              ),
            ),
          ],
        ));
  }

  setRoomStatus() async {
    try {
      setState(() {
        isLoading = true;
      });

      String status = 'Damaged';
      if (cleaned) {
        status = 'Cleaned';
      } else if (notCleaned) {
        status = 'NotCleaned';
      }

      ApiResponse res = await MainRepository()
          .setRoomStatus(roomId, status, occupation_status);
      log(this, res.status);

      RoomsController.to.getRooms();

      Get.offNamedUntil(Routes.DASHBOARD, (route) => false);
      Toast.success('request_submitted'.tr, 'submitted'.tr);
    } catch (e) {
      log(this, e);
      Toast.error(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
