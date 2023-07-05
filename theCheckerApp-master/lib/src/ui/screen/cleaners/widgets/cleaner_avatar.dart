import 'package:checkerapp/src/ui/widget/tap_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../../src/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../../network/routes.dart';
import '../../../../utils/widgets/cached_image.dart';
import '../../../theme/app_colors.dart';

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
              FutureBuilder(
                  future: Utils.getValidatedNetworkImageWidget(
                      "${Routes.baseURL}/$image",
                      const CircleAvatar(
                        radius: 80,
                        child: Icon(Icons.person),
                      )),
                  builder: (context, snapshot) {
                    return snapshot.hasData == true
                        ? snapshot.data as Widget
                        : const CircularProgressIndicator();
                  }),
              // CachedImageWidget(
              //   image: "${Routes.baseURL}/$image",
              //   errorWidget: (context, url, error) {
              //     return const CircleAvatar(
              //       radius: 80,
              //       child: Icon(Icons.person),
              //     );
              //   },
              // ),
            ],
            // "${Routes.baseURL}/$image",
            8.ph,
            SizedBox(
              width: 160,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: Get.theme.textTheme.titleMedium,
              ).setStyle(size: 15, weight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
