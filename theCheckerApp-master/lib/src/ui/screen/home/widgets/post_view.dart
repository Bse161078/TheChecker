
import 'package:checkerapp/src/utils/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';
import '../../../theme/app_colors.dart';

class PostView extends StatelessWidget {
  // final Post post;
  final bool inPostDetail;
  final VoidCallback? imageTap;
  const PostView({Key? key, this.inPostDetail = false, this.imageTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [

                if(inPostDetail)...[
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()=>Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: arrowBackColor, size: 24,)
                  ),
                ],

                Center(
                  child: Container(
                    // margin: const EdgeInsets.only(bottom: 40),
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[350],
                      // image: DecorationImage(
                      //   image: NetworkImage('${post.artist?.avatar?.url}'),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text('${post.artist?.firstname} ${post.artist?.lastname}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15, height: 1.1),),
                    // Text('${post.location?.city}', style: TextStyle(color: Colors.grey[600], height: 1.1),)
                  ],
                ).paddingOnly(left: 8),

              ],
            ),
            
            Row(
              children: const [
                Icon(Icons.check_rounded, color: Colors.black,),
                Text('Following', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),),
              ],
            ),

          ],
        ).paddingOnly(left: inPostDetail ? 0 : 16, right: 16),
        
        // image slider
        // GestureDetector(onTap: imageTap, child: PostSliderWidget(images: post.images).paddingSymmetric(vertical: 8)),

        // actions
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/images/bookmark.svg', width: 18,),
            const SizedBox(width: 20,),
            CupertinoButton(
              onPressed: () {
                // var address = Uri(scheme: 'https', path: 'posts/${post.id}', host: 'artwork.us').toString();
                // print('Address: $address');
                // Share.share(address);
              },
              padding: EdgeInsets.zero,
              child: SvgPicture.asset('assets/images/share.svg', width: 18,)
            ),
          ],
        ).paddingOnly(left: 16),

        // description
        if(!inPostDetail)...{

          // SizedBox(width: Get.width / 1.2, child: Text('${post.caption}', maxLines: 1, textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey[800]),),).paddingOnly(left: 16, right: 16, top: 2),

          // price track
          // if(post.discountPercentage == null || post.discountPercentage == 0) ...[
          //   Text('\$${post.price}', style: const TextStyle(fontSize: 15,color: Colors.black, fontWeight: FontWeight.w600),).paddingOnly(left: 16),
          // ] else ...[
          //   Row(
          //     children: [
          //       Text('\$${post.price - (post.price * (post.discountPercentage / 100)) }', style: const TextStyle(fontSize: 15,color: Colors.black, fontWeight: FontWeight.w600),),
          //       const SizedBox(width: 6,),
          //       Text('\$${post.price}', style: TextStyle(fontSize: 13,color: Colors.grey[600], fontWeight: FontWeight.w600, decoration: TextDecoration.lineThrough,),),
          //       const SizedBox(width: 6,),
          //       Text('${post.discountPercentage}%',).setStyle(color: Colors.red, weight: FontWeight.w500),
          //     ],
          //   ).paddingOnly(left: 16)
          // ],

          const SizedBox(height: 22,)

        }


      ],
    );
  }
}
