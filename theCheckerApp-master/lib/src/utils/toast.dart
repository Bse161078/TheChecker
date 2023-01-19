
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Toast{

  static error(msg){
    Get.snackbar('', '',
      backgroundColor: Colors.black.withOpacity(.6),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      maxWidth: Get.width / 5,
      borderRadius: 8,
      snackPosition: SnackPosition.BOTTOM,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInCubic,
      titleText: const Text('Error!',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      messageText: Text('$msg',textAlign: TextAlign.left,textDirection: TextDirection.rtl,style: const TextStyle(color: Colors.white),),
    );
  }

  static warn(msg){
    Get.snackbar('', '',
      backgroundColor: Colors.orange,
      margin: const EdgeInsets.all(16),
      maxWidth: Get.width / 5,
      borderRadius: 8,
      duration: const Duration(seconds: 2),
      titleText: const Text('Warning!',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      messageText: Text('$msg',textAlign: TextAlign.left,textDirection: TextDirection.rtl,style: const TextStyle(color: Colors.white),),
    );
  }

  static success(msg,[title]){
    Get.snackbar('', '',
      backgroundColor: Colors.green,
      maxWidth: Get.width / 5,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      titleText: Text(title ?? 'Created',textAlign: TextAlign.left,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      messageText: Text('$msg',textAlign: TextAlign.left,textDirection: TextDirection.rtl,style: const TextStyle(color: Colors.white),),
    );
  }

  static info(title, msg){
    Get.snackbar('', '',
      backgroundColor: Colors.blue,
      maxWidth: Get.width / 5,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      titleText: Text('$title',textAlign: TextAlign.left,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      messageText: Text('$msg',textAlign: TextAlign.left,textDirection: TextDirection.rtl,style: const TextStyle(color: Colors.white),),
    );
  }

}
