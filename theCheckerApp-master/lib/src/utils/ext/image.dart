
import 'package:checkerapp/src/network/routes.dart';

extension ImagePath on String{
  String get toSvg => "assets/images/$this.svg";
  String get toPng => "assets/images/$this.png";
  String get toJpg => "assets/images/$this.jpg";
  String get toJpeg => "assets/images/$this.jpeg";
  String get toImageUrl => "${Routes.baseURL}/$this";
}