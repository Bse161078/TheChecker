
import 'package:flutter/cupertino.dart';

class Tap extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const Tap({Key? key, required this.child, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(onPressed: onTap, padding: EdgeInsets.zero,child: child,);
  }
}
