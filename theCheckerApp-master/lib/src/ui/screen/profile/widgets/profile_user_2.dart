
import 'dart:convert';

import 'package:checkerapp/src/controllers/rooms_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../main.dart';
import '../../../../routes/app_pages.dart';
import '../../../../storage/pref.dart';
import '../../../theme/app_colors.dart';

class ProfileUser2 extends GetView<RoomsController> {

  @override
  Widget build(BuildContext context) {
    return GetX<RoomsController>(builder: (_) {
      _.isLoading;

      // ProfileModel profileModel = ProfileModel.fromJson(jsonDecode(Pref.to.profileVal));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(
            children: [

              CupertinoButton(
                // onPressed: ()=> _.setupData.value.coverURI == null ? chooseImageDialog(context) : chooseImageDialogWithDelete(context),
                padding: EdgeInsets.zero,
                onPressed: () {  },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  width: Get.width,
                  height: Get.height / 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // child: _.setupData.value.coverURI == null ?
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/camera.png', width: 28,),
                      const Text('Upload', style: TextStyle(color: Colors.grey, fontSize: 12),)
                    ],
                  )
          // :
          //         kIsWeb ?
          //         ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.memory(Uint8List.fromList(hex2Unit('${_.setupData.value.coverURI}')),width: Get.width,fit: BoxFit.cover,)) :
          //         ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(File('${_.setupData.value.coverURI}'),)),

                ),
              ),

              Positioned(
                bottom: 15,
                left: 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Stack(
                      alignment: Alignment.center,
                      children: [

                        Container(
                          width: (Get.width / 5) + 7,
                          height: (Get.width / 5) + 7,
                          decoration: const BoxDecoration(
                            color: backgroundColor,
                            shape: BoxShape.circle,
                          ),
                        ),

                        Container(
                          width: Get.width / 5,
                          height: Get.width / 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              // _.setupData.value.photoURI == null ?
                              Image.asset('assets/images/photo-placeholder.png', width: Get.width / 12,)
                                  // :
                              // kIsWeb ?
                              // ClipRRect(borderRadius: BorderRadius.circular(Get.width / 2.5), child: Image.memory(Uint8List.fromList(hex2Unit('${_.setupData.value.photoURI}')), width: Get.width / 5, height: Get.width / 5,)) :
                              // ClipRRect(borderRadius: BorderRadius.circular(Get.width / 2.5), child: Image.file(File('${_.setupData.value.photoURI}'), width: Get.width / 5, height: Get.width / 5,)),

                            ],
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(width: 8,),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('${profileModel.firstname} ${profileModel.lastname}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),),
                        Text('California, Irvine', style: TextStyle(color: Colors.grey[600],fontSize: 11),),
                      ],
                    ).paddingOnly(bottom: 5),

                  ],
                ),
              ),

              Positioned(
                bottom: 30,
                right: 5,
                child: Row(
                  children: const[
                    Icon(Icons.favorite_border),
                    SizedBox(width: 12,),
                    Icon(Icons.share_rounded),
                  ],
                ),
              )

            ],
          ),

          // Text('${profileModel.bio}', overflow: TextOverflow.ellipsis,maxLines: 5,textAlign: TextAlign.left,).setStyle(color: Colors.grey[600]),

          const SizedBox(height: 12,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  // CupertinoButton(
                  //   onPressed: () => Navigator.pushNamed(context, Routes.FOLLOWING),
                  //   padding: EdgeInsets.zero,
                  //   child: Wrap(
                  //     direction: Axis.vertical,
                  //     alignment: WrapAlignment.center,
                  //     crossAxisAlignment:  WrapCrossAlignment.center,
                  //     spacing: -5,
                  //     runSpacing: -5,
                  //     children: [
                  //       Text('${_.meFollowingCount.value}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13),),
                  //       Text('Following', style: TextStyle(color: Colors.grey[600], fontSize: 12),),
                  //     ],
                  //   ),
                  // ),

                  Container(
                    width: 1.5,
                    height: 25,
                    color: Colors.grey[400],
                  ).paddingSymmetric(horizontal: 10),

                  // CupertinoButton(
                  //   onPressed: () => Navigator.pushNamed(context, Routes.FOLLOWERS),
                  //   padding: EdgeInsets.zero,
                  //   child: Wrap(
                  //     direction: Axis.vertical,
                  //     alignment: WrapAlignment.center,
                  //     crossAxisAlignment:  WrapCrossAlignment.center,
                  //     spacing: -5,
                  //     runSpacing: -5,
                  //     children: [
                  //       Text('${_.meFollowerCount.value}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13),),
                  //       Text('Followers', style: TextStyle(color: Colors.grey[600], fontSize: 12),),
                  //     ],
                  //   ),
                  // ),

                ],
              ),

              Row(
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1, color: Colors.grey)
                      ),
                      // margin: margin,
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          false ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: .9,)) :
                          Row(
                            children: [
                              const Icon(CupertinoIcons.lock, color: Colors.grey, size: 18,).paddingOnly(right: 4),
                              const Text('Message', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6,),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                      ),
                      // margin: margin,
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          // false ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: .9,)) :
                          Text('Follow', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 16);
    });
  }

}