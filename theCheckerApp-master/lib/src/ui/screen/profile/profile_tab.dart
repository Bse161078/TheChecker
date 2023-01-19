import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../src/storage/pref.dart';
import '../../../../src/ui/screen/profile/widgets/profile_user_2.dart';
import '../../../../src/ui/theme/app_colors.dart';
import '../../../controllers/rooms_controller.dart';
import '../../../routes/app_pages.dart';
import '../../widget/empty_view.dart';

class ProfileTab extends GetView<RoomsController> {
  @override
  Widget build(BuildContext context) {
    return GetX<RoomsController>(initState: (_) {
      // if (Pref.to.tokenVal.isNotEmpty) {
      // controller
      //   ..getFollowingCount()
      //   ..getFollowerCount();
      // }
    }, builder: (_) {
      // ProfileModel? profileModel;
      // if (Pref.to.tokenVal.isNotEmpty && Pref.to.profileVal.isNotEmpty) {
      //   profileModel =
      //       ProfileModel.fromJson(jsonDecode(Pref.to.profileVal.toString()));
      // }

      _.isLoading;
      return Scaffold(
          backgroundColor: backgroundColor,
          appBar: Pref.to.tokenVal.isEmpty
              ? AppBar(
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: backgroundColor,
                  title: const Text(
                    'Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : AppBar(
                  automaticallyImplyLeading: false,
                  actions: [
                    // CupertinoButton(
                    //   onPressed: () =>
                    //       Navigator.pushNamed(context, Routes.SETTINGS),
                    //   padding: EdgeInsets.zero,
                    //   child: SvgPicture.asset(
                    //     'assets/images/right-menu.svg',
                    //     width: 27,
                    //   ),
                    // ),
                  ],
                  centerTitle: false,
                  elevation: 0,
                  backgroundColor: backgroundColor,
                  title: const Text(
                    'You',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
          floatingActionButton:  FloatingActionButton(
            tooltip: 'New Post',
            onPressed: (){},
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
          ).paddingOnly(bottom: 70),
          body: Pref.to.tokenVal.isEmpty
              ? EmptyView(
                  imageNamePng: 'profile-illustrate.png',
                  titleText: 'Nothing here',
                  middleText:
                      'Please sign in to contact artists, track your purchase, and also manage your profile.',
                  actionName: 'Sign in',
                  visibleLogo: false,
                  onPressed: () =>
                      Get.toNamed(Routes.LOGIN, arguments: 'closable'))
              // : profileModel == null
              //     ? const Center(
              //         child: SizedBox(
              //             width: 25,
              //             height: 25,
              //             child: CircularProgressIndicator(
              //               color: Colors.black,
              //               strokeWidth: .7,
              //             )))
              //     : profileModel.role == 1
              //         ? ProfileUser1()
              //         : ProfileUser2()
      :null);
    });
  }
}
