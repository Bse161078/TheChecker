import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../theme/app_colors.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  // late Post post;

  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    // post = Post.fromJson(Get.arguments);
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Center(
            child: PageView(
              scrollDirection: Axis.horizontal,
              onPageChanged: _onPageViewChange,
              controller: _pageController,
              children: <Widget>[
                // for (int i = 0; i < post.images!.length; i++)
                //   image('${post.images![i].url}')
              ],
            ),
          ),
          Positioned(
            left: 8,
            top: Get.mediaQuery.viewPadding.top + 16,
            child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Get.back(),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // for (int i = 0; i < post.images!.length; i++)
                //   CupertinoButton(
                //     padding: EdgeInsets.zero,
                //     onPressed: () {
                //       _pageController.jumpToPage(i);
                //       _pageController.animateToPage(i, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                //     },
                //     child: Container(
                //       margin: const EdgeInsets.only(right: 6),
                //         decoration: BoxDecoration(
                //           border: _currentPageIndex == i ? Border.all(color: Colors.black, width: 2.4) : null
                //         ),
                //         child: Image.network(
                //       '${post.images![i].url}',
                //       fit: BoxFit.cover,
                //       width: 40,
                //       height: 40,
                //     )),
                //   )
              ],
            ).paddingOnly(bottom: 22),
          ),
        ],
      ),
    );
  }

  _onPageViewChange(int page) {
    setState(() {
      _currentPageIndex = page;
    });
  }

  // Widget image(String url) {
  //   return CachedNetworkImage(
  //     width: Get.width,
  //     fit: BoxFit.fitWidth,
  //     imageUrl: url.toString(),
  //     placeholder: (context, url) => Container(
  //       width: Get.width,
  //       height: 400,
  //       decoration: BoxDecoration(
  //         color: Colors.grey[300],
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         mainAxisSize: MainAxisSize.min,
  //         children: const [
  //           SizedBox(
  //               width: 22,
  //               height: 22,
  //               child: CircularProgressIndicator(
  //                 color: Colors.black,
  //                 strokeWidth: .7,
  //               )),
  //         ],
  //       ),
  //     ),
  //     errorWidget: (context, url, error) => const Icon(Icons.error),
  //   );
  // }
}
