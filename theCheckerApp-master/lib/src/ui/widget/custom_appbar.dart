//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'button_widget.dart';
//
// PreferredSize appbarWithSearch(context,String caption,Function searchPress, [visibleSearchBtn = true]) {
//   var top = MediaQuery.of(context).padding.top + 8;
//
//   return PreferredSize(
//     preferredSize: const Size.fromHeight(55.0),
//     child: AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//       flexibleSpace: Padding(
//         padding: Platform.isIOS ? const EdgeInsets.only(top: 48) : EdgeInsets.only(top: top),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16),
//                   child: MyButton(
//                       onPressed: (){
//                         Get.find<CallController>().drawerOpenClose();
//                       },
//                       child: SizedBox(width: 20,height: 20,child: SvgPicture.asset('assets/images/open-drawer-icon.svg',))
//                   ),
//                 ),
//
//                 if(visibleSearchBtn)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 16),
//                   child: Row(
//                     children: [
//
//                       MyButton(
//                         onPressed: ()=>searchPress(),
//                         child: SizedBox(width: 20,height: 20,child: SvgPicture.asset('assets/images/search-icon.svg',)),
//                       ),
//
//                     ],
//                   ),
//                 )
//
//               ],
//             ),
//
//             Padding(
//               padding: const EdgeInsets.only(top: 0),
//               child: Text(caption.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17, letterSpacing: .4),),
//             ),
//
//           ],
//         ),
//       ),
//       // .improveLayoutOnIphone(),
//     ),
//   );
// }
//
// PreferredSize appbarWithBack( context, String title, Function backPress) {
//   var top = MediaQuery.of(context).padding.top ;
//
//   return PreferredSize(
//     preferredSize: const Size.fromHeight(55.0),
//     child:  AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//
//       flexibleSpace: Padding(
//         padding: Platform.isIOS ? const EdgeInsets.only(top: 30) : EdgeInsets.only(top: top),
//         child: Stack(
//           children: [
//
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 4, left: 16),
//                 child: Row(
//                   children: [
//
//                     MyButton(
//                         onPressed: ()=>backPress(),
//                         child: SizedBox(width: 18,height: 18,child: SvgPicture.asset('assets/images/arrow-left-icon.svg',)),
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.only(left: 12),
//                       child: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//       // .improveLayoutOnIphone(),
//     ),
//   );
// }
//
// PreferredSize appbarWithBackSubmit(context, String title, Function backPress, Widget submitChild) {
//   var top = MediaQuery.of(context).padding.top ;
//
//   return PreferredSize(
//     preferredSize: const Size.fromHeight(55.0),
//     child:  AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//
//       flexibleSpace: Padding(
//         padding: Platform.isIOS ? const EdgeInsets.only(top: 30) : EdgeInsets.only(top: top),
//         child: Stack(
//           children: [
//
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 4, left: 16),
//                 child: Row(
//                   children: [
//                     MyButton(
//                         onPressed: ()=>backPress(),
//                         child: SizedBox(width: 18,height: 18,child: SvgPicture.asset('assets/images/arrow-left-icon.svg',))),
//
//                     Padding(
//                       padding: const EdgeInsets.only(left: 12),
//                       child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//
//             Align(
//               alignment: Alignment.centerRight,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 4,right: 16),
//                 child: submitChild,
//               ),
//             ),
//
//           ],
//         ),
//       ),
//       // .improveLayoutOnIphone(),
//     ),
//   );
// }