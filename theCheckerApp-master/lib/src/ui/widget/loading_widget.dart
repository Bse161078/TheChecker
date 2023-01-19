import 'package:flutter/material.dart';
import '../../../../src/ui/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {

  final color;

  const LoadingWidget({Key? key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: color ?? primaryColor,strokeWidth: 1,);
  }
}