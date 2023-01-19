
import '../../../src/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import 'button_widget.dart';

class EmptyView extends StatelessWidget {

  final String imageNamePng;
  final String titleText;
  final String middleText;
  final String? actionName;
  final bool visibleLogo;
  final VoidCallback onPressed;
  final double imageWidthFactor;
  const EmptyView({Key? key, required this.imageNamePng, required this.titleText, required this.middleText, this.actionName, required this.onPressed, this.visibleLogo = true, this.imageWidthFactor = 2.2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        if(visibleLogo)...[
          Padding(
            padding: EdgeInsets.only(top: (Get.mediaQuery.viewPadding.top + 16)),
            child: Center(child: SvgPicture.asset('assets/images/splash-artwork.svg',width: 90,)),
          ),
        ] else ...[
          const SizedBox(),
        ],


        Column(
          children: [
            Center(child: Image.asset('assets/images/$imageNamePng',width:  Get.width / imageWidthFactor,)),
            const SizedBox(height: 16,),
            Text(titleText, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
            const SizedBox(height: 24,),
            Text(middleText, style: TextStyle(fontSize: 12, color: Colors.grey[600]),textAlign: TextAlign.center,).paddingSymmetric(horizontal: 22),
            // const SizedBox(height: 42,),
          ],
        ),


        actionName != null ? SizedBox(
          width: Get.width / 2,
          child: Btn(label: actionName ?? '', margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16), onPressed: onPressed),
        ) : const SizedBox(),

        const SizedBox(),

      ],
    ).improveLayoutOnIphone();
  }
}
