
import 'package:flutter/foundation.dart';

bool enableLog = true;
void log(className, log) {
  if (!enableLog){
    return;
  }
  if (kDebugMode) {
    print('[CheckerApp][${className.runtimeType}] -> $log');
  }
}