import 'package:checkerapp/src/utils/widgets/cached_image.dart';
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

import 'package:checkerapp/src/network/routes.dart' as Route;

class Cleaners extends StatefulWidget {
  const Cleaners({Key? key}) : super(key: key);

  @override
  State<Cleaners> createState() => _CleanersState();
}

class _CleanersState extends State<Cleaners> {
  TextEditingController controllerSearchBox = TextEditingController();

  late Room room;

  var previousRoute = '';

  CleanersController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX<CleanersController>(
      initState: (_) {
        room = Get.arguments ?? Room();
        previousRoute = Get.previousRoute;

        controller.getCleaners();

        controller.filteredCleaners = controller.cleanersList;
        print(
            "Filtered cleaners number: ${controller.filteredCleaners.length}");
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
                        setState(() {
                          controller.searchCleaners(controllerSearchBox.text);
                        });
                      },
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),

              Expanded(
                child: GridView(
                  primary: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  children: [
                    for (int index = 0;
                        index < controller.filteredCleaners.length;
                        index++)
                      FadeAnimation(
                        delay: .15 * index,
                        child: CleanerAvatar(
                          image: '${controller.filteredCleaners[index].avatar}',
                          name:
                              '${controller.filteredCleaners[index].fullname}',
                          onTap: () {
                            if (previousRoute
                                .toString()
                                .contains('/dashboard')) {
                              _showDialog(
                                context,
                                controller.filteredCleaners[index],
                              );
                            } else {
                              if (room.status == "IN_PROGRESS") {
                                Get.toNamed(
                                  Routes.CHECKLIST,
                                  arguments: [
                                    room,
                                    controller.filteredCleaners[index]
                                  ],
                                );
                              } else {
                                Get.toNamed(
                                  Routes.CONTINUE_ORDER,
                                  arguments: [
                                    room,
                                    controller.filteredCleaners[index]
                                  ],
                                );
                              }
                            }
                          },
                        ),
                      ),
                  ],
                ),
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
            24.ph,
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                        ],
                      ),
                    ),
                  ] else
                    FutureBuilder(
                        future: Utils.getValidatedNetworkImageWidget(
                            "${Route.Routes.baseURL}/${cleaner.avatar}",
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
                  //   image: ,
                  //   errorWidget: (a, b, c) => const CircleAvatar(
                  //     radius: 80,
                  //     child: Icon(Icons.person),
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
            28.ph,
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}
