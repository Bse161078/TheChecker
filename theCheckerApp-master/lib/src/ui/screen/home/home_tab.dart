
import 'package:checkerapp/src/controllers/rooms_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../src/ui/theme/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../storage/pref.dart';
import '../../widget/empty_view.dart';

class Home extends GetView<RoomsController> {

  var token;

  @override
  Widget build(BuildContext context) {
    return GetX<RoomsController>(
        initState: (state) {
          token = Get.find<Pref>().getString(Pref.token);
        },
        builder: (_) {
          token = Get.find<Pref>().getString(Pref.token);
          _.isLoading;
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: token.toString().isEmpty ? null : AppBar(
                centerTitle: true,
                elevation: 2.0,
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Discover for you',),
                    Tab(text: 'By your following',),
                  ],
                  indicatorColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                ),
                title: SvgPicture.asset('assets/images/splash-artwork.svg',width: 70,),
                backgroundColor: backgroundColor,
              ),
              body: token.toString().isEmpty ? guestView() :
                TabBarView(
                  children: [
                  ]
                ),
            ),
          );
        }
      );
  }

  Widget guestView() {
    return EmptyView(
        imageNamePng: 'home-illustrate.png',
        titleText: 'Welcome to ARTWRK',
        middleText: 'Please sign in to contact artists, track your purchase, and also manage your profile.',
        actionName: 'Get started',
        onPressed: ()=>Get.toNamed(Routes.LOGIN,arguments: 'closable')
    );
  }

}
