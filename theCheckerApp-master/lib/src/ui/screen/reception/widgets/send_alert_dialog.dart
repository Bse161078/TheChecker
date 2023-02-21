import 'package:checkerapp/src/controllers/reception_controller.dart';
import 'package:checkerapp/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/room_model.dart';
import '../../../../data/repository/main_repository.dart';
import '../../../../network/response.dart';
import '../../../theme/app_colors.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/checker.dart';

/// Created by amir on 22, December, 2022

class SendAlertDialog extends StatefulWidget {
  final Room room;
  const SendAlertDialog({Key? key, required this.room}) : super(key: key);

  @override
  _SendAlertDialogState createState() => _SendAlertDialogState();
}

class _SendAlertDialogState extends State<SendAlertDialog> {
  bool CleanQuick = false;
  bool ExtraBedNormal = false;
  bool ExtraBedChild = false;
  bool RedCard = false;
  bool CleanStay = false;
  bool CleanCheckout = false;
  bool CleanAgain = false;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width / 2.2,
        child: SingleChildScrollView(
          child: Column(
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
                  middle: Text('send_alert'.tr),
                ),
              ),
              16.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: redColor,
                    size: 63,
                  ),
                ],
              ),
              16.ph,
              Row(
                children: [
                  SizedBox(
                    width: Get.width / 3.5,
                    child: Text(
                      'pls_enter_alert_msg'.tr,
                      style: Get.textTheme.titleMedium,
                    ).setStyle(size: 16).paddingOnly(left: 24, top: 24),
                  ),
                ],
              ),
              30.ph,
              SizedBox(
                  width: Get.width / 2.5,
                  child: Checker(
                      label: 'clean_quick_guest_waiting'.tr,
                      hasBorder: true,
                      state: CleanQuick,
                      type: CheckerType.Radio,
                      longText: false,
                      onChanged: (value) {
                        setState(() {
                          CleanQuick = value;
                        });
                      })),
              10.ph,
              SizedBox(
                  width: Get.width / 2.5,
                  child: Checker(
                      label: 'extra_bed_normal'.tr,
                      hasBorder: true,
                      state: ExtraBedNormal,
                      type: CheckerType.Radio,
                      longText: false,
                      onChanged: (value) {
                        setState(() {
                          ExtraBedNormal = value;
                        });
                      })),
              10.ph,
              SizedBox(
                  width: Get.width / 2.5,
                  child: Checker(
                      label: 'extra_bed_child'.tr,
                      hasBorder: true,
                      state: ExtraBedChild,
                      type: CheckerType.Radio,
                      longText: false,
                      onChanged: (value) {
                        setState(() {
                          ExtraBedChild = value;
                        });
                      })),
              10.ph,
              SizedBox(
                  width: Get.width / 2.5,
                  child: Checker(
                      label: 'red_card'.tr,
                      hasBorder: true,
                      state: RedCard,
                      type: CheckerType.Radio,
                      longText: false,
                      onChanged: (value) {
                        setState(() {
                          RedCard = value;
                        });
                      })),
              10.ph,
              SizedBox(
                  width: Get.width / 2.5,
                  child: Checker(
                      label: 'clean_stay'.tr,
                      hasBorder: true,
                      state: CleanStay,
                      type: CheckerType.Radio,
                      longText: false,
                      onChanged: (value) {
                        setState(() {
                          CleanStay = value;
                        });
                      })),
              10.ph,
              SizedBox(
                  width: Get.width / 2.5,
                  child: Checker(
                      label: 'clean_checkout'.tr,
                      hasBorder: true,
                      state: CleanCheckout,
                      type: CheckerType.Radio,
                      longText: false,
                      onChanged: (value) {
                        setState(() {
                          CleanCheckout = value;
                        });
                      })),
              10.ph,
              SizedBox(
                  width: Get.width / 2.5,
                  child: Checker(
                      label: 'clean_again'.tr,
                      hasBorder: true,
                      state: CleanAgain,
                      type: CheckerType.Radio,
                      longText: false,
                      onChanged: (value) {
                        setState(() {
                          CleanAgain = value;
                        });
                      })),
              30.ph,
              SizedBox(
                width: Get.width / 4.2,
                child: Btn(
                  label: 'send_alert'.tr,
                  isLoading: isLoading,
                  onPressed: () => sendAlert(),
                ),
              ),
              34.ph,
            ],
          ),
        ));
  }

  sendAlert() async {
    try {
      setState(() {
        isLoading = true;
      });

      // CleanQuick *
      // ExtraBedNormal *
      // ExtraBedChild *
      // RedCard *
      // CleanStay *
      // CleanCheckout *
      // CleanAgain *

      List<String> status = [];
      if (CleanQuick) {
        status.add('Clean Quick Guest Waiting');
      }
      if (ExtraBedNormal) {
        status.add('Extra Bed Normal');
      }
      if (ExtraBedChild) {
        status.add('Extra Bed Child');
      }
      if (CleanStay) {
        status.add('Clean Stay');
      }
      if (CleanCheckout) {
        status.add('Clean Checkout');
      }
      if (CleanAgain) {
        status.add('Clean Again');
      }
      if (RedCard) {
        status.add('Red Card');
      }

      ApiResponse res =
          await MainRepository().sendAlert(widget.room.id!, status);
      log(this, res.status);

      ReceptionController receptionController = Get.find();
      receptionController.getRooms();

      Get.back();
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
