import 'package:cached_network_image/cached_network_image.dart';
import 'package:checkerapp/src/controllers/notifications_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../controllers/cleaners_controller.dart';
import '../../../controllers/materials_controller.dart';
import '../../../controllers/rooms_controller.dart';
import '../../../utils/widgets/cached_image.dart';
import 'widget/material_box_view.dart';
import 'package:flutter/cupertino.dart';

import '../../../storage/pref.dart';
import '../../widget/button_widget.dart';
import '../../widget/tap_widget.dart';
import 'widget/cleaners_box_view.dart';
import 'widget/notification_box_view.dart';
import 'widget/rooms_box_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/dashboard_controller.dart';
import '../../../../src/utils/utils.dart';
import '../../../routes/app_pages.dart';
import 'package:checkerapp/src/network/routes.dart' as Route;

class Dashboard extends GetView<DashboardController> {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<DashboardController>(initState: (_) {
      CleanersController.to.getCleaners();
      RoomsController.to.getRooms();
      MaterialsController.to.getMaterials();

      // if .report in any roomsList isNotEmpty then add 1 to notifNumber

      controller.getProfile();
    }, builder: (_) {
      _.isLoading;

      return Scaffold(
          body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        height: 90,
                        width: 90,
                        imageUrl:
                            "${Route.Routes.baseURL}/${Pref.to.hotelLogoCheckerVal}",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Container(),
                      ),
                    ),
                    1.ph,
                  ],
                ).background(Get.theme.cardColor),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    16.ph,
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Get.width > 800
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CleanersBoxView(
                                  onTap: () => Get.toNamed(Routes.CLEANERS),
                                  cleanersNo:
                                      '${CleanersController.to.cleanersList.length}',
                                ),
                                RoomsBoxView(
                                  onTap: () => Get.toNamed(Routes.ROOMS),
                                  roomsNo:
                                      '${RoomsController.to.roomsList.length}',
                                ),
                                MaterialBoxView(
                                  onTap: () => Get.toNamed(Routes.MATERIALS),
                                  itemNo:
                                      '${MaterialsController.to.materialList.length}',
                                ),
                                NotficationBoxView(
                                  onTap: () =>
                                      Get.toNamed(Routes.NOTIFICATIONS),
                                  itemNo: NotificationController.to
                                      .getNotifNumber()
                                      .toString(),
                                )
                              ],
                            )
                          : GridView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2,
                                mainAxisSpacing: 15,
                              ),
                              children: [
                                CleanersBoxView(
                                  onTap: () => Get.toNamed(Routes.CLEANERS),
                                  cleanersNo:
                                      '${CleanersController.to.cleanersList.length}',
                                ),
                                RoomsBoxView(
                                  onTap: () => Get.toNamed(Routes.ROOMS),
                                  roomsNo:
                                      '${RoomsController.to.roomsList.length}',
                                ),
                                MaterialBoxView(
                                  onTap: () => Get.toNamed(Routes.MATERIALS),
                                  itemNo:
                                      '${MaterialsController.to.materialList.length}',
                                ),
                                NotficationBoxView(
                                  onTap: () =>
                                      Get.toNamed(Routes.NOTIFICATIONS),
                                  itemNo: NotificationController.to
                                      .getNotifNumber()
                                      .toString(),
                                )
                              ],
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Powered by',
                              style: TextStyle(height: 0),
                            ).setStyle(size: 13, weight: FontWeight.w500),
                            16.ph,
                            Image.asset(
                              'logo'.toPng,
                              width: 160,
                            ),
                            24.ph
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              Expanded(
                flex: 5,
                child: Baseline(
                  baseline: 84,
                  baselineType: TextBaseline.alphabetic,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CachedImageWidget(
                            image:
                                "${Route.Routes.baseURL}/${Pref.to.userAvatarVal}",
                            errorWidget: (context, url, error) {
                              return const CircleAvatar(
                                radius: 80,
                                child: Icon(Icons.person),
                              );
                            },
                          ),
                          14.ph,
                          Text(
                            Pref.to.nameVal,
                            style: Get.theme.textTheme.titleMedium,
                          ).setStyle(size: 15, weight: FontWeight.w600),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Tap(
                onTap: () => _showDialog(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('sign_out'.tr)
                        .setStyle(color: Colors.red, weight: FontWeight.w500),
                    6.pw,
                    const Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 20,
                    ),
                  ],
                ).paddingSymmetric(horizontal: 22, vertical: 32)),
          ),
        ],
      ));
    });
  }

  void _showDialog(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SizedBox(
        width: Get.width / 2.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12)),
              child: CupertinoNavigationBar(
                leading: CupertinoNavigationBarBackButton(
                  previousPageTitle: 'cancel'.tr,
                  onPressed: () => Get.back(),
                ),
                middle: Text('sign_out'.tr),
              ),
            ),
            Row(
              children: [
                Text(
                  'want_to_sign_out'.tr,
                  style: Get.textTheme.titleMedium,
                ).setStyle(size: 16).paddingOnly(left: 24, top: 24),
              ],
            ),
            34.ph,
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Btn(
                        label: 'cancel'.tr,
                        onPressed: () => Get.back(),
                        direction: TextDirection.rtl,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 9))),
                16.pw,
                Expanded(
                  flex: 1,
                  child: Btn(
                    label: 'sign_out'.tr,
                    onPressed: () {
                      Pref.to.clear();
                      Get.offNamed(Routes.SPLASH);
                      try {
                        FirebaseMessaging.instance
                            .unsubscribeFromTopic(Pref.to.idVal);
                      } catch (e) {
                        log(this, 'e: $e');
                      }
                    },
                    secondaryBtn: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 24),
            24.ph,
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}
