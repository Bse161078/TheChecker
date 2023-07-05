// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class CachedImageWidget extends StatelessWidget {
//   const CachedImageWidget({
//     super.key,
//     required this.image,
//     required this.errorWidget,
//   });

//   final String image;
//   final Widget Function(BuildContext, String, dynamic)? errorWidget;

//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: image,
//       imageBuilder: (context, imageProvider) => CircleAvatar(
//         radius: 80,
//         backgroundColor: Colors.white,
//         backgroundImage: imageProvider,
//       ),
//       errorWidget: errorWidget,
//     );
//   }
// }
