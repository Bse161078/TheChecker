import 'package:checkerapp/src/ui/widget/tap_widget.dart';
import 'package:flutter/cupertino.dart';

import '../../../../src/ui/widget/textfield_widget.dart';
import '../../../../src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../storage/locale_pref.dart';
import '../../widget/button_widget.dart';
import '../../widget/checker.dart';

class Login extends GetView<AuthController> {
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  final locales = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'German', 'locale': const Locale('de', 'DE')},
  ];

  _showLocaleDialog(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SizedBox(
        width: Get.width / 2.2,
        child: Obx(() {
          controller.isLoading;
          return Column(
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
                  middle: Text('choose_lang'.tr),
                ),
              ),

              16.ph,

              Row(
                children: [
                  SizedBox(
                      width: Get.width / 3.5,
                      child: Text(
                        'pls_choose_your_lang'.tr,
                        style: Get.textTheme.subtitle1,
                      ).setStyle(size: 16).paddingOnly(left: 24, top: 24)),
                ],
              ),

              30.ph,

              SizedBox(
                  width: Get.width / 4.8,
                  child: Checker(
                      label: '${locales[0]['name']}',
                      hasBorder: true,
                      state: Get.locale?.languageCode == 'en',
                      type: CheckerType.Radio,
                      longText: false,
                      onChanged: (value) {
                        updateLocale(
                          locales[0]['locale'] as Locale,
                          context,
                        );
                      })),
              10.ph,
              SizedBox(
                  width: Get.width / 4.8,
                  child: Checker(
                      label: '${locales[1]['name']}',
                      hasBorder: true,
                      state: Get.locale?.languageCode == 'de',
                      type: CheckerType.Radio,
                      longText: false,
                      onChanged: (value) {
                        updateLocale(
                          locales[1]['locale'] as Locale,
                          context,
                        );
                      })),
              // 10.ph,
              // SizedBox(width: Get.width / 4.8, child: Btn(label: 'apply'.tr, onPressed: ()=>Get.back())),
              44.ph,
            ],
          );
        }),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  updateLocale(Locale locale, BuildContext context) {
    Navigator.of(context).pop();
    setLocale(locale.languageCode, '${locale.countryCode}');
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    var _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    log(this, 'key:: $_keyboardVisible');

    return GetX<AuthController>(initState: (_) {
      // controllerUser.text= 'amiecheckerx';
      // controllerPass.text= '12345678';
      controllerUser.addListener(() => _checkInputs());
      controllerPass.addListener(() => _checkInputs());
    }, builder: (_) {
      _.isLoading;
      return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [],
                  ),
                  SizedBox(
                    width: Get.width / 3.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'logo'.toPng,
                          width: Get.width / 4.5,
                        ),
                        58.ph,
                        TxtField(
                          controller: controllerUser,
                          label: 'username'.tr,
                        ),
                        12.ph,
                        TxtField(
                          controller: controllerPass,
                          label: 'pass'.tr,
                          inputAction: TextInputAction.done,
                          isObscure: _.obscurePass.value,
                          obscureTap: () =>
                              _.obscurePass.value = !_.obscurePass.value,
                        ),
                        12.ph,
                        Btn(
                          label: 'login'.tr,
                          onPressed: () =>
                              _.enabledLoginButton.value ? _signIn() : null,
                          isLoading: _.isLoading,
                          enabled: _.enabledLoginButton.value,
                        ),
                      ],
                    ),
                  ),
                  1.ph,
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Tap(
                    onTap: () => _showLocaleDialog(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.language,
                          color: Get.theme.primaryColor,
                        ),
                        8.pw,
                        Text(Get.locale?.languageCode == 'en'
                                ? 'English'
                                : 'German')
                            .setStyle(
                                color: Get.theme.highlightColor, size: 16),
                      ],
                    ).paddingOnly(top: 38, right: 26)),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  opacity: _keyboardVisible ? 0 : 1,
                  duration: const Duration(milliseconds: 120),
                  child: Row(
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
                ),
              ),
            ],
          ));
    });
  }

  _checkInputs() {
    if (controllerUser.text.isNotEmpty && controllerPass.text.isNotEmpty) {
      AuthController.to.enabledLoginButton.value = true;
    } else {
      AuthController.to.enabledLoginButton.value = false;
    }
  }

  _checkValidation() {
    if (controllerUser.text.isEmpty) {
      Toast.error('enter_username'.tr);
      return false;
    }
    if (controllerPass.text.isEmpty) {
      Toast.error('enter_pass'.tr);
      return false;
    }
    return true;
  }

  _signIn() {
    if (AuthController.to.isLoading == true) {
      return;
    }

    if (!_checkValidation()) {
      return;
    }

    AuthController.to.login(controllerUser.text, controllerPass.text);
  }
}
