
import 'package:flutter/material.dart';

class HeaderTile extends StatelessWidget {

  final String titleText;
  final String? middleText;
  final EdgeInsetsGeometry margin;
  const HeaderTile({Key? key, required this.titleText, this.middleText, this.margin = const EdgeInsets.only(left: 16, top: 24, bottom: 16)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(titleText, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),textAlign: TextAlign.start,),
            ],
          ),
          if(middleText != null) ... [
            Text(middleText!, style: TextStyle( color: Colors.grey[600], fontWeight: FontWeight.w400, fontSize: 12),textAlign: TextAlign.start)
          ]

        ],
      ),
    );
  }
}
