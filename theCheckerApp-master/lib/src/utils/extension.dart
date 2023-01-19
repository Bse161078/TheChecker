import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as time;
import 'package:flutter/foundation.dart' show kIsWeb;


extension TextExtension on Text {
  // Text setStyle(TextStyle style) => copyWith(style: style);

  Text setStyle({Color? color, double? size, FontWeight? weight}) =>
      copyWith(style: TextStyle(color: color, fontSize: size, fontWeight: weight));

  Text copyWith(
      {Key? key,
        StrutStyle? strutStyle,
        TextAlign? textAlign,
        TextDirection? textDirection,
        Locale? locale,
        bool? softWrap,
        TextOverflow? overflow,
        double? textScaleFactor,
        int? maxLines,
        String? semanticsLabel,
        TextWidthBasis? textWidthBasis,
        TextStyle? style,
      }) {
    return Text(data ?? '',
        key: key ?? this.key,
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: textAlign ?? this.textAlign,
        textDirection: textDirection ?? TextDirection.ltr,
        locale: locale ?? this.locale,
        softWrap: softWrap ?? this.softWrap,
        overflow: overflow ?? this.overflow,
        textScaleFactor: textScaleFactor ?? this.textScaleFactor,
        maxLines: maxLines ?? this.maxLines,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
        textWidthBasis: textWidthBasis ?? this.textWidthBasis,
        style: style != null ? this.style?.merge(style) ?? style : this.style);
  }
}

// extension EventExtension on TZDateTime {
//   String get shortTime => '$hour:$minute';
// }

extension DatePickerExtension on DateTime {
  String get shortTime => time.DateFormat("MMM, d EEEE").format(this);
  DateTime get firstHourOfDay => DateTime(year,month,day);
  DateTime get lastHourOfDay => DateTime(year,month,day,24);

  int differenceInMin(other){
    int startTimeInMinutes = hour * 60 + minute;
    int endTimeInMinutes = other.hour * 60 + other.minute;
    int dif = endTimeInMinutes - startTimeInMinutes;
    return dif;
  }

  bool isValidTimeRange(TimeOfDay startTime, TimeOfDay endTime) {
    TimeOfDay now = TimeOfDay.now();
    return ((now.hour > startTime.hour) || (now.hour == startTime.hour && now.minute >= startTime.minute))
        && ((now.hour < endTime.hour) || (now.hour == endTime.hour && now.minute <= endTime.minute));
  }

}

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ThemeData get appTheme => Theme.of(this);

  MaterialColor get randomColor => Colors.primaries[Random().nextInt(17)];

  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;

  Brightness get appBrightness => MediaQuery.of(this).platformBrightness;

}

extension WidgetModifier on Widget {

  Widget improveLayoutOnIphone() {
    if(kIsWeb){
      return this;
    }
    if (Platform.isIOS) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: this,
      );
    } else {
      return this;
    }
  }

  Widget background(Color color) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
      ),
      child: this,
    );
  }


  Widget sized(double w, double h) {
    return SizedBox(
      width: w,
      height: h,
      child: this,
    );
  }

  Widget align([AlignmentGeometry alignment = Alignment.center]) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }
}

// extension StringExtension on String {
//   int get toInt => int.parse(this);
//
//   Future<bool> get launchUrl => launch(this);
// }

// extension StringColorExtension on String {
//   Color get color => Color(int.parse('0xff$this'));
// }
//
// extension StringValidatorExtension on String {
//   bool get isValidEmail => RegExp(RegexConstans.instance.emailRegex).hasMatch(this);
// }
//
// extension AuthorizationExtension on String {
//   Map<String, dynamic> get beraer => {'Authorization': 'Bearer ${this}'};
// }
//
// extension LaunchExtension on String {
//   Future<bool> get launchEmail => launch('mailto:$this');
// }
//
// extension ShareText on String {
//   Future<void> shareWhatsApp() async {
//     try {
//       final isLaunch = await launch('${KartalAppConstants.WHATS_APP_PREFIX}$this');
//       if (!isLaunch) await share();
//     } catch (e) {
//       await share();
//     }
//   }
// }
//
// extension FormatterExtension on String {
//   String get phoneFormatValue => InputFormatter.instance.phoneFormatter.unmaskText(this);
// }
//
// extension FormatterExtension on String {
//   String get getExtensionFile => {
//
//
//   File file = new File("/dir1/dir2/file.ext");
//   String basename = basename(file.path);
//   return '';
//   };
// }
