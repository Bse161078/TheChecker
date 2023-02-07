import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/cleaner_model.dart';
import '../../../data/model/room_model.dart';
import '../../theme/app_colors.dart';
import '../../widget/fade_animation.dart';
import '../../../routes/app_pages.dart';
import '../../../ui/screen/cleaners/widgets/cleaner_avatar.dart';
import '../../../../src/controllers/cleaners_controller.dart';
import '../../../../src/ui/widget/textfield_widget.dart';
import '../../../../src/utils/utils.dart';
import '../../widget/button_widget.dart';

class Cleaners extends GetView<CleanersController> {
  TextEditingController controllerSearchBox = TextEditingController();
  late Room room;

  var previousRoute = '';

  List<Cleaner> filteredCleaners = [];

  Cleaners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CleanersController>(
      initState: (_) {
        room = Get.arguments ?? Room();
        previousRoute = Get.previousRoute;

        controller.getCleaners();

        filteredCleaners = controller.cleanersList;
      },

      // didUpdateWidget: (oldWidget, newWidget) {
      //   // filteredCleaners = controller.cleanersList;
      // },
      builder: (cleanersController) {
        cleanersController.isLoading;

        return Scaffold(
          appBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              previousPageTitle: previousRoute.toString().contains('/dashboard')
                  ? 'home'.tr
                  : 'rooms'.tr,
              onPressed: () => Get.back(),
            ),
            middle: Text('select_cleaner'.tr),
          ),
          body: Column(
            children: [
              // search bar
              Row(
                children: [
                  Flexible(
                    child: TxtField(
                      controller: controllerSearchBox,
                      label: 'search_cleaner'.tr,
                      hasSearchIcon: true,
                    ),
                  ),
                  8.pw,
                  SizedBox(
                    width: 130,
                    height: 48,
                    child: Btn(
                      label: 'search'.tr,
                      onPressed: () {
                        print('search');
                        filteredCleaners = cleanersController.cleanersList
                            .where(
                              (cleaner) =>
                                  cleaner.fullname!.toLowerCase().contains(
                                        controllerSearchBox.text.toLowerCase(),
                                      ),
                            )
                            .toList();

                        cleanersController.update();

                        for (var cleaner in filteredCleaners) {
                          print(cleaner.fullname);
                        }
                      },
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),

              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: filteredCleaners.length,
                itemBuilder: (context, index) {
                  return FadeAnimation(
                    delay: .15 * index,
                    child: CleanerAvatar(
                      image: '${filteredCleaners[index].avatar}',
                      name: '${filteredCleaners[index].fullname}',
                      onTap: () {
                        if (previousRoute.toString().contains('/dashboard')) {
                          _showDialog(
                            context,
                            filteredCleaners[index],
                          );
                        } else {
                          Get.toNamed(
                            Routes.CHECKLIST,
                            arguments: [room, filteredCleaners[index]],
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDialog(BuildContext context, Cleaner cleaner) {
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
                middle: Text('cleaner_profile'.tr),
              ),
            ),

            // Row(
            //   children: [
            //     Text('enter_detail_of_new_cleaner'.tr, style: Get.textTheme.subtitle1,).setStyle(size: 16).paddingOnly(left: 24, top: 24),
            //   ],
            // ),

            24.ph,

            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CircleAvatar(
                  //   radius: 80, // Image radius
                  //   backgroundImage: NetworkImage('${cleaner.avatar}'.toImageUrl),
                  // ),

                  if (cleaner.avatar == '' || cleaner.avatar == 'null') ...[
                    CircleAvatar(
                      radius: 80, // Image radius
                      backgroundColor: const Color(0x330BBBEF),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            CupertinoIcons.person_fill,
                            color: primaryColor,
                            size: 60,
                          ),
                          // Text('add_photo'.tr,style: Get.textTheme.subtitle1).setStyle(size: 16, weight: FontWeight.w600),
                        ],
                      ),
                    ),
                  ] else ...[
                    CircleAvatar(
                      radius: 80, // Image radius
                      backgroundImage:
                          NetworkImage(cleaner.avatar.toString().toImageUrl),
                    ),
                  ],

                  // CircleAvatar(
                  //   radius: 80, // Image radius
                  //   backgroundColor: const Color(0x330BBBEF),
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       const Icon(CupertinoIcons.person_fill, color: primaryColor, size: 60,),
                  //       Text('add_photo'.tr,style: Get.textTheme.subtitle1).setStyle(size: 16, weight: FontWeight.w600),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            28.ph,
            TxtField(
                    controller: TextEditingController(text: cleaner.fullname),
                    readOnly: true,
                    label: 'full_name'.tr)
                .paddingSymmetric(horizontal: 24),
            // 12.ph,
            // TxtField(controller: TextEditingController(), label: 'phone'.tr).paddingSymmetric(horizontal: 24),

            28.ph,
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}
