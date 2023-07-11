export 'ext/image.dart';
export 'extension.dart';
export 'ext/padding.dart';
export 'logger.dart';
export 'toast.dart';
export 'ext/string.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

import "package:checkerapp/src/utils/logger.dart";

class Utils {
  static copy(value) {
    Clipboard.setData(ClipboardData(text: value));
  }

  static Future<String> paste() async {
    ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
    return '${cdata?.text.toString()}';
  }

  static bool validateMobile(String value) {
    if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
        .hasMatch(value)) {
      return false;
    }

    if (value.length >= 10 && value.length <= 12) {
      if (value.length == 10) {
        return true;
      }

      if (value.length == 11 && value.startsWith('1')) {
        return true;
      }

      if (value.length == 12 && value.startsWith('+1')) {
        return true;
      }

      return false;
    } else {
      return false;
    }
  }

  static String rmUnusedChar(value) {
    return value
        .toString()
        .replaceAll('Optional', '')
        .replaceAll('(', '')
        .replaceAll(')', '');
  }

  static String fileExtension(String path) {
    File file = File(path);
    String extension = file.path.split('/').last.split('.').last;
    return extension.toLowerCase();
  }

  static utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  // static vibrate() {
  //   if(Platform.isAndroid || Platform.isIOS){
  //     if(Platform.isIOS){
  //       var _type = FeedbackType.light;
  //       Vibrate.feedback(_type);
  //     }else{
  //       var _type = FeedbackType.medium;
  //       Vibrate.feedback(_type);
  //     }
  //   }
  // }

  static timestampToDate(int millis) {
    try {
      var dd = DateTime.fromMillisecondsSinceEpoch(millis * 1000);
      return DateFormat("hh:mm a").format(dd);
      // var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt); // 12/31/2000, 10:00 PM
      // var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt); // 31/12/2000, 22:00
    } catch (_) {
      return '$millis';
    }
  }

  static formatDateTimeFromUtc(dynamic time) {
    try {
      return DateFormat("E d MMM hh:mm a")
          .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(time));
    } catch (e) {
      return DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    }
  }

  static dateTimeFromUtc(dynamic time) {
    try {
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(time);
    } catch (e) {
      return DateTime.now();
    }
  }

  static String remoteAddressToExtension(String remoteAddress) {
    String adr = remoteAddress.toString();
    if (adr.contains('@')) {
      return adr.split('@').first.replaceAll('sip:', '');
    } else {
      return adr;
    }
  }

  static SnackBar snackBar(String text) {
    return SnackBar(
      content: Text(
        text,
        // style: The),
        // textAlign: TextAlign.right,
      ),
      backgroundColor: Colors.black.withOpacity(.7),
      duration: const Duration(seconds: 1),
    );
  }

  Future<bool> connectivityChecker() async {
    var connected = false;
    // Logger().w('utils', "Checking internet...");
    try {
      final result = await InternetAddress.lookup('google.com');
      final result2 = await InternetAddress.lookup('facebook.com');
      final result3 = await InternetAddress.lookup('microsoft.com');
      if ((result.isNotEmpty && result[0].rawAddress.isNotEmpty) ||
          (result2.isNotEmpty && result2[0].rawAddress.isNotEmpty) ||
          (result3.isNotEmpty && result3[0].rawAddress.isNotEmpty)) {
        // Logger().w('utils', 'connected..');
        connected = true;
      } else {
        // Logger().w('utils', 'not connected...');
        connected = false;
      }
    } on SocketException catch (_) {
      // Logger().e('utils', 'not connected...');
      connected = false;
    }
    return connected;
  }

  static Color randomOpaqueColor() {
    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
  }

  static Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 0.4));

    return hslLight.toColor();
  }

  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static configStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  // static String fileExtension(String path) {
  //   File file = File(path);
  //   String extension = file.path.split('/').last.split('.').last;
  //   return extension;
  // }
  static bool checkIfImage(String param) {
    if (param == 'image/jpeg' || param == 'image/png' || param == 'image/gif') {
      return true;
    }
    return false;
  }

  static Future<bool> validateImage(String imageUrl) async {
    http.Response res;
    try {
      res = await http.get(Uri.parse(imageUrl));
    } catch (e) {
      return false;
    }

    if (res.statusCode != 200) return false;
    Map<String, dynamic> data = res.headers;
    return checkIfImage(data['content-type']);
  }

  static Future<Widget> getValidatedNetworkImageWidget(
      String link, Widget errorWidget) async {
    log("Utils Class", link);
    if (await Utils.validateImage(link)) {
      return CircleAvatar(
        radius: 70,
        backgroundImage: NetworkImage(
          link,
        ),
      );
    } else {
      return errorWidget;
    }
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
