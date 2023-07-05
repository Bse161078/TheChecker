import 'dart:async';

import '../../../../src/ui/widget/fade_animation.dart';
import '../../../../src/utils/utils.dart';
import '../../../routes/app_pages.dart';
import '../../../storage/pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:checkerapp/src/network/routes.dart' as Route;

class Splash extends StatefulWidget {
  const Splash({Key? key, this.hotelLogo}) : super(key: key);

  final String? hotelLogo;

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () async {
      String token = Pref.to.tokenVal;
      print('token: $token');
      if (token.isEmpty) {
        Get.offNamed(Routes.LOGIN);
      } else {
        log(this, 'role ${Pref.to.roleVal}');
        if (Pref.to.roleVal == 'Checker') {
          Get.offNamed(Routes.DASHBOARD);
        } else {
          Get.offNamed(Routes.RECEPTION);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeAnimation(
        delay: 1,
        child: Center(
          child: SizedBox(
              width: Get.width / 3,
              child: widget.hotelLogo == null
                  ? Image.asset(
                      'logo'.toPng,
                    )
                  : FutureBuilder(
                      future: Utils.getValidatedNetworkImageWidget(
                          "${Route.Routes.baseURL}/${widget.hotelLogo!}",
                          const CircleAvatar(
                            radius: 80,
                          )),
                      builder: (context, snapshot) {
                        return snapshot.hasData == true
                            ? snapshot.data as Widget
                            : const Center(child: CircularProgressIndicator());
                      })
              // CachedNetworkImage(
              //     imageUrl: "${Route.Routes.baseURL}/${widget.hotelLogo!}",
              //     placeholder: (context, url) =>
              //         const Center(child: CircularProgressIndicator()),
              //     errorWidget: (context, url, error) => Container(),
              //   ),
              ),
        ),
      ),
    );
  }
}
