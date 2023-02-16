import 'package:cached_network_image/cached_network_image.dart';
import 'package:checkerapp/src/ui/widget/tap_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../../src/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

import 'package:checkerapp/src/network/routes.dart';

class CleanerAvatar extends StatelessWidget {
  final String image;
  final String name;
  final VoidCallback onTap;
  const CleanerAvatar(
      {Key? key, required this.image, required this.name, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Get.theme.splashColor,
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image.isEmpty || image == 'null') ...[
              CircleAvatar(
                radius: 80, // Image radius
                backgroundColor: const Color(0x330BBBEF),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      CupertinoIcons.person_fill,
                      color: primaryColor,
                      size: 60,
                    ),
                    // Text('add_photo'.tr,style: Get.textTheme.subtitle1).setStyle(size: 16, weight: FontWeight.w600),
                  ],
                ),
              ),
            ] else ...[
              CircleAvatar(
                radius: 80, // Image radius
                child: CachedNetworkImage(
                  imageUrl: "${Routes.baseURL}/$image",
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.person),
                ),
              ),
            ],
            8.ph,
            Text(
              name,
              style: Get.theme.textTheme.titleMedium,
            ).setStyle(size: 15, weight: FontWeight.w600),
          ],
        ),
      ),
    );
  }
}
