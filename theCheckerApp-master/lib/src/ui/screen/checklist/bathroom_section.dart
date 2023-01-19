

import 'dart:io';

import 'package:checkerapp/src/controllers/checklist_controller.dart';
import 'package:checkerapp/src/ui/screen/checklist/widgets/add_photos_view.dart';
import 'package:checkerapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';
import '../../widget/answer_yes_no_widget.dart';
import '../../widget/button_widget.dart';
import '../../widget/checker.dart';
import '../../widget/tap_widget.dart';
import '../cleaners/widgets/cleaner_avatar.dart';

class BathroomSection extends GetView<CheckListController>{

  TextEditingController controllerReport = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetX<CheckListController>(
        initState: (_){
          controllerReport.text = controller.bathroomDamageReport.value;
        },
        builder: (_) {
          if(controllerReport.text.isEmpty){
            controllerReport.text = controller.bathroomDamageReport.value;
          }
          _.isLoading;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('bathroom'.tr, style: Get.textTheme.subtitle1,).setStyle(size: 18, weight: FontWeight.bold),
                16.ph,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Get.theme.splashColor,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('bathroom_is_clean'.tr, style: Get.textTheme.subtitle1,).setStyle(size: 16),
                            10.ph,
                            AnswerYesNoWidget(state: controller.bathroomIsCleaned.value, onChangeValue: (newState)=> controller.bathroomIsCleaned.value = newState)
                          ],
                        ),
                      ),
                    ),
                    16.pw,

                    Tap(
                      onTap: () async{
                        final XFile? photo = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if(photo==null){
                          return;
                        }
                        _.bathroomIsCleanedPhoto.add(photo.path);
                      },
                      child: Container(
                        child: _.bathroomIsCleanedPhoto.isNotEmpty ?
                        ClipRRect(borderRadius: BorderRadius.circular(8),child: Image.file(File(_.bathroomIsCleanedPhoto.last), width: 170, height: 110,fit: BoxFit.cover,)) :
                        Container(
                          width: 170,
                          height: 110,
                          decoration: BoxDecoration(
                              color: Get.theme.splashColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo, color: Get.theme.primaryColor,size: 30,),
                              8.ph,
                              Text('add_photos'.tr).setStyle(color: Colors.white, size: 16)
                            ],
                          ),
                        ),
                      ),
                    )


                  ],
                ),


                22.ph,
                Text('comments'.tr, style: Get.textTheme.subtitle1,).setStyle(size: 14),
                8.ph,
                Container(
                  // height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Get.theme.splashColor,
                  ),
                  // padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checker(label: 'tiles_not_mopped'.tr, state: controller.bathroomTilesNotMopped.value, type: CheckerType.Check, onChanged: (newValue)=>controller.bathroomTilesNotMopped.value = newValue),
                          AddPhotosView(onSelectPhoto: (photoPath){_.bathroomTilesNotMoppedPhoto.add(photoPath);_.isLoading = true;_.isLoading = false;}, photos: _.bathroomTilesNotMoppedPhoto),
                        ],
                      ).paddingOnly(top: 6, bottom: 4),
                      const Divider(height: 4,).paddingSymmetric(horizontal: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checker(label: 'toilet_not_wiped'.tr, state: controller.bathroomToiletNotWiped.value, type: CheckerType.Check, onChanged: (newValue)=>controller.bathroomToiletNotWiped.value = newValue),
                          AddPhotosView(onSelectPhoto: (photoPath){_.bathroomToiletNotWipedPhoto.add(photoPath);_.isLoading = true;_.isLoading = false;}, photos: _.bathroomToiletNotWipedPhoto),
                        ],
                      ).paddingOnly(top: 6, bottom: 4),
                      const Divider(height: 4,).paddingSymmetric(horizontal: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checker(label: 'dirt_in_shower'.tr, state: controller.bathroomDirtInShower.value, type: CheckerType.Check, onChanged: (newValue)=>controller.bathroomDirtInShower.value = newValue),
                          AddPhotosView(onSelectPhoto: (photoPath){_.bathroomDirtInShowerPhoto.add(photoPath);_.isLoading = true;_.isLoading = false;}, photos: _.bathroomDirtInShowerPhoto),
                        ],
                      ).paddingOnly(top: 6, bottom: 4),
                      const Divider(height: 4,).paddingSymmetric(horizontal: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checker(label: 'shelves_not_wiped'.tr, state: controller.bathroomShelvesNotWiped.value, type: CheckerType.Check, onChanged: (newValue)=>controller.bathroomShelvesNotWiped.value = newValue),
                          AddPhotosView(onSelectPhoto: (photoPath){_.bathroomShelvesNotWipedPhoto.add(photoPath);_.isLoading = true;_.isLoading = false;}, photos: _.bathroomShelvesNotWipedPhoto),
                        ],
                      ).paddingOnly(top: 6, bottom: 4),
                      const Divider(height: 4,).paddingSymmetric(horizontal: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checker(label: 'trays_not_filled'.tr, state: controller.bathroomTraysNotFilled.value, type: CheckerType.Check, onChanged: (newValue)=>controller.bathroomTraysNotFilled.value = newValue),
                          AddPhotosView(onSelectPhoto: (photoPath){_.bathroomTraysNotFilledPhoto.add(photoPath);_.isLoading = true;_.isLoading = false;}, photos: _.bathroomTraysNotFilledPhoto),
                        ],
                      ).paddingOnly(top: 6, bottom: 4),


                    ],
                  ),
                ),

                22.ph,
                Text('damage_report'.tr, style: Get.textTheme.subtitle1,).setStyle(size: 14),
                8.ph,
                Container(
                  // height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Get.theme.splashColor,
                  ),
                  // padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      TextField(
                        textInputAction: TextInputAction.newline,
                        controller: controllerReport,
                        textAlign: TextAlign.left,
                        onChanged: (t){
                          controller.bathroomDamageReport.value = t;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          counterText: "",
                          contentPadding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 12,
                            bottom: 0,
                          ),
                          hintText: 'enter_additional_report'.tr,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintStyle: TextStyle(fontWeight: FontWeight.w300,color: Get.theme.hintColor, fontSize: 14),
                        ),
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        maxLength: 500,
                      ),
                      6.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AddPhotosView(onSelectPhoto: (photoPath){_.bathroomDamageReportPhoto.add(photoPath);_.isLoading = true;_.isLoading = false;}, photos: _.bathroomDamageReportPhoto),
                        ],
                      ),
                      6.ph,
                    ],
                  ),
                ),

                68.ph,
              ],
            ).paddingOnly(left: 22, right: 22, top: 22),
          );
        });
  }


}