
import 'dart:convert';

class ApiResponse{

  final int status;
  final dynamic body;
  final String url;
  final dynamic parameters;

  ApiResponse(
      {required this.status, required this.body, required this.url, this.parameters});

  // get body {
  //   if(body.toString().isNotEmpty){
  //     return json.decode(body.toString());
  //   }else{
  //     return [];
  //   }
  // }

  @override
  String toString() {
    return 'Response: [$url][$parameters][$status][$body]';
  }

}