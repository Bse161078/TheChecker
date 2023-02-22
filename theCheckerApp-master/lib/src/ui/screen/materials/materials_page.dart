import '../../widget/button_widget.dart';
import '../../widget/checker.dart';
import 'widgets/material_row_view.dart';
import '../../../controllers/materials_controller.dart';
import 'package:flutter/cupertino.dart';
import '../../../../src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/tap_widget.dart';

class Materials extends GetView<MaterialsController> {
  const Materials({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MaterialsController>(
        initState: (_) {},
        builder: (_) {
          _.isLoading;

          return Scaffold(
              appBar: CupertinoNavigationBar(
                middle: Text('materials_list'.tr),
                leading: CupertinoNavigationBarBackButton(
                  previousPageTitle: 'home'.tr,
                  onPressed: () => Get.back(),
                ),
                trailing: Tap(
                    onTap: () => _submitOrderDialog(context),
                    child: Text('next'.tr).setStyle(
                        color: Get.theme.primaryColor,
                        weight: FontWeight.w500)),
              ),
              body: Column(
                children: [
                  18.ph,
                  Container(
                    // height: 110,
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Get.theme.splashColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < _.materialList.length; i += 2)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialRowView(
                                    label: '${_.materialList[i].name}',
                                    isChecked:
                                        _.materialList[i].isChecked ?? false,
                                    onChangeState: (state) {
                                      _.materialList[i].isChecked = state;
                                      _.isLoading = true;
                                      _.isLoading = false;
                                    },
                                    onChangeQty: (qty) =>
                                        _.materialList[i].quantity = qty,
                                  ),
                                  8.pw,
                                  if ((i + 1) < _.materialList.length) ...[
                                    MaterialRowView(
                                      label: '${_.materialList[i + 1].name}',
                                      isChecked:
                                          _.materialList[i + 1].isChecked ??
                                              false,
                                      onChangeState: (state) {
                                        _.materialList[i + 1].isChecked = state;
                                        _.isLoading = true;
                                        _.isLoading = false;
                                      },
                                      onChangeQty: (qty) =>
                                          _.materialList[i + 1].quantity = qty,
                                    ),
                                  ] else ...[
                                    const Expanded(flex: 1, child: SizedBox())
                                  ]
                                ],
                              ),
                              const Divider(
                                height: 4,
                              ).paddingSymmetric(horizontal: 12),
                            ],
                          ),
                      ],
                    ),
                  ),
                  16.ph,
                ],
              ));
        });
  }

  _submitOrderDialog(BuildContext context) {
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
                    middle: Text('order_items'.tr),
                  ),
                ),
                16.ph,
                Row(
                  children: [
                    SizedBox(
                        width: Get.width / 3.5,
                        child: Text(
                          'select_where_order_sent'.tr,
                          style: Get.textTheme.titleMedium,
                        ).setStyle(size: 16).paddingOnly(left: 24, top: 24)),
                  ],
                ),
                30.ph,
                SizedBox(
                    width: Get.width / 4.8,
                    child: Checker(
                        label: 'hotel_management'.tr,
                        hasBorder: true,
                        state: controller.orderHotelManagement.value,
                        type: CheckerType.Radio,
                        longText: false,
                        onChanged: (value) {
                          controller.orderHotelManagement.value = true;
                          controller.orderCleaningCompany.value = false;
                        })),
                10.ph,
                SizedBox(
                    width: Get.width / 4.8,
                    child: Checker(
                        label: 'cleaning_company'.tr,
                        hasBorder: true,
                        state: controller.orderCleaningCompany.value,
                        type: CheckerType.Radio,
                        longText: false,
                        onChanged: (value) {
                          controller.orderHotelManagement.value = false;
                          controller.orderCleaningCompany.value = true;
                        })),
                10.ph,
                SizedBox(
                    width: Get.width / 4.8,
                    child: Btn(
                        label: 'order'.tr,
                        isLoading: controller.secondaryIsLoading,
                        onPressed: () {
                          if (controller.orderHotelManagement.value == false &&
                              controller.orderCleaningCompany.value == false) {
                            return;
                          }
                          controller.saveMaterials();
                        })),
                34.ph,
              ],
            )),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}
