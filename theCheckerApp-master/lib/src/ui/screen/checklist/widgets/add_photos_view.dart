
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/utils.dart';
import '../../../widget/button_widget.dart';


/// Created by amir on 18, December, 2022
class AddPhotosView extends StatelessWidget {

  final List<String> photos;
  final Function onSelectPhoto;
  const AddPhotosView({Key? key, required this.onSelectPhoto, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (photos.isNotEmpty) ...[
          ClipRRect(borderRadius: BorderRadius.circular(6.0), child: Image.file(File(photos.last), width: 55, height: 38, fit: BoxFit.cover,)),
          12.pw,
        ],
        Btn(label: 'add_photos'.tr, onPressed: () async{
          final XFile? photo = await ImagePicker().pickImage(source: ImageSource.gallery);
          if(photo==null){
            return;
          }
          onSelectPhoto(photo.path);
        }, secondaryBtn: true, iconData: Icons.photo, iconColor: Get.theme.primaryColor, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),).paddingOnly(right: 12),
      ],
    );
  }
}
