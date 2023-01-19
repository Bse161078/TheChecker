
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

class Cleaners extends GetView<CleanersController>{

  TextEditingController controllerSearchBox = TextEditingController();
  late Room room;

  var previousRoute = '';

  @override
  Widget build(BuildContext context) {
    return GetX<CleanersController>(
      initState: (_){
        room = Get.arguments ?? Room();
        previousRoute = Get.previousRoute;
      },
      builder: (_) {
        _.isLoading;

        return Scaffold(
          appBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              previousPageTitle: previousRoute.toString().contains('/dashboard') ? 'home'.tr : 'rooms'.tr,
              onPressed: () =>Get.back(),
            ),
            middle: Text('select_cleaner'.tr),
          ),
          body: Column(
            children: [
              18.ph,

              // search bar
              Row(
                children: [
                  Flexible(child: TxtField(controller: controllerSearchBox, label: 'search_cleaner'.tr, hasSearchIcon: true,)),
                  8.pw,
                  SizedBox(width: 130, height: 47, child: Btn(label: 'search'.tr, onPressed: (){})),
                ],
              ).paddingSymmetric(horizontal: 16),

              24.ph,

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Wrap(
                    spacing: 32,
                    runSpacing: 32,
                    children: [

                      for(int i=0; i<_.cleanersList.length;i++)
                        FadeAnimation(delay: .15 * i, child: CleanerAvatar(
                          image: '${_.cleanersList[i].avatar}',
                          name: '${_.cleanersList[i].fullname}',
                          onTap: () {
                            if(previousRoute.toString().contains('/dashboard')){
                              _showDialog(context, _.cleanersList[i]);
                            }else {
                              Get.toNamed(Routes.CHECKLIST, arguments: [room, _.cleanersList[i]]);
                            }
                          },
                        ),
                        ),

                      // FadeAnimation(delay: .15 * 7, child: NewCleanerButton(onTap: ()=>_showDialog(context)),),

                    ],
                  ),
                ),
              ),

            ],
          ));
      });
  }

  void _showDialog(BuildContext context, Cleaner cleaner) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SizedBox(
        width: Get.width / 2.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            ClipRRect(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
              child: CupertinoNavigationBar(
                leading: CupertinoNavigationBarBackButton(
                  previousPageTitle: 'cancel'.tr,
                  onPressed: () =>Get.back(),
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
              onPressed: (){

              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CircleAvatar(
                  //   radius: 80, // Image radius
                  //   backgroundImage: NetworkImage('${cleaner.avatar}'.toImageUrl),
                  // ),

                  if(cleaner.avatar=='' || cleaner.avatar=='null') ... [
                    CircleAvatar(
                      radius: 80, // Image radius
                      backgroundColor: const Color(0x330BBBEF),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(CupertinoIcons.person_fill, color: primaryColor, size: 60,),
                          // Text('add_photo'.tr,style: Get.textTheme.subtitle1).setStyle(size: 16, weight: FontWeight.w600),
                        ],
                      ),
                    ),

                  ] else ... [
                    CircleAvatar(
                      radius: 80, // Image radius
                      backgroundImage: NetworkImage(cleaner.avatar.toString().toImageUrl),
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
            TxtField(controller: TextEditingController(text: cleaner.fullname), readOnly: true, label: 'full_name'.tr).paddingSymmetric(horizontal: 24),
            // 12.ph,
            // TxtField(controller: TextEditingController(), label: 'phone'.tr).paddingSymmetric(horizontal: 24),

            28.ph,

          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);
  }

}