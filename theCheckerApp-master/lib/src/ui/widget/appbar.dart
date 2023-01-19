
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class Appbar extends StatelessWidget {
  final String title;
  final VoidCallback backPressed;
  const Appbar({Key? key, required this.title, required this.backPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: backPressed,
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: arrowBackColor, size: 19,)
                ),
              ],
            ),
          ),

          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Center(child: Text(title.toUpperCase(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),)),
          ),

          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox(), //Container
          ) //Flexible
        ],
      ),
    );
  }
}
