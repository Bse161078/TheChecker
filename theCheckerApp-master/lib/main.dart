// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../src/binding/main_binding.dart';
import '../src/ui/theme/app_translations.dart';
import 'src/routes/app_pages.dart';
import 'src/storage/locale_pref.dart';
import 'src/storage/pref.dart';
import 'src/ui/theme/app_theme.dart';
import 'src/ui/widget/runtime_error.dart';
import 'src/utils/utils.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // titlecription
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  // NotificationSettings settings =
  //     await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // print('User granted permission: ${settings.authorizationStatus}');

  runApp(const CheckerApp());
}

class CheckerApp extends StatefulWidget {
  const CheckerApp({Key? key}) : super(key: key);

  @override
  State<CheckerApp> createState() => _CheckerAppState();
}

class _CheckerAppState extends State<CheckerApp> {
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        log(this, "Preference Revoked ${locale.languageCode}");
        Get.updateLocale(locale);
        log(this, "GET LOCALE Revoked ${Get.locale?.languageCode}");
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         ));
    //   }
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   if (Pref.to.roleVal == 'Checker') {
    //     Get.offNamed(Routes.DASHBOARD);
    //   } else {
    //     Get.offNamed(Routes.RECEPTION);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH,
      initialBinding: MainBinding(),
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('de', 'DE'),
      // locale: const Locale('en', 'US'),
      // fallbackLocale: const Locale('en', 'US'),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      defaultTransition: Transition.cupertino,
      getPages: AppPages.pages,
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return RuntimeErrorView(errorDetails: errorDetails);
        };
        return widget!;
      },
    );
  }
}
