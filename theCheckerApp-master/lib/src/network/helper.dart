import 'dart:async';
import 'dart:convert';
import '../../src/utils/utils.dart';
import 'package:http/http.dart' as http;
import '../storage/pref.dart';
import 'exception.dart';
import 'response.dart';

enum Method { GET, POST, PUT, DELETE }

class ServiceProvider {
  static Future<ApiResponse> execute(String url, Method method,
      [var data, List<int>? acceptedStatus]) async {
    try {
      int serviceTimeout = 10;
      final uri = Uri.parse(url);
      final token = Pref.to.tokenVal.toBearer;
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': token
      };

      print("Inside Service Provider, header is: $header");

      http.Response res;
      switch (method) {
        case Method.POST:
          print("Posting to $url with data: $data ");
          res = await http
              .post(uri, headers: header, body: jsonEncode(data))
              .timeout(Duration(seconds: serviceTimeout));
          break;
        case Method.GET:
          print("Get request to $url ");
          res = await http
              .get(uri, headers: header)
              .timeout(Duration(seconds: serviceTimeout));
          break;
        case Method.PUT:
          res = await http
              .put(uri, headers: header, body: jsonEncode(data))
              .timeout(Duration(seconds: serviceTimeout));
          break;
        case Method.DELETE:
          res = await http
              .delete(uri, headers: header, body: jsonEncode(data))
              .timeout(Duration(seconds: serviceTimeout));
          break;
      }

      var body;
      if (res.body.toString().isNotEmpty) {
        body = json.decode(res.body.toString());
      } else {
        body = [];
      }

      if (acceptedStatus == null || acceptedStatus.contains(res.statusCode)) {
        return ApiResponse(status: res.statusCode, body: body, url: url);
      } else {
        throw EndUserException(body['errors']['message']);
      }
    } catch (e) {
      log('this', 'b');
      throw ApiException(e).toString();
    }
  }

  // Future<dynamic> getWithoutTrusted(String url) async {
  //
  //   var responseJson;
  //   try{
  //
  //     final ioc = HttpClient();
  //     ioc.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;
  //     final httpd = IOClient(ioc);
  //
  //     final response  = await httpd.get(
  //       Uri.parse(url),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Accept': 'application/json',
  //         // 'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(const Duration(seconds: 20));
  //     responseJson = ApiResponse.returnResponse(response);
  //
  //   } on TimeoutException catch (_){
  //     throw Exception("TimedOut");
  //   } on SocketException {
  //     throw Exception('No Internet connection');
  //   } on HttpException {
  //     throw Exception("Couldn't find the post");
  //   } on FormatException {
  //     throw Exception("Bad response format 👎");
  //   }
  //   print('==============\n  get service url: $url \n=> $responseJson \n');
  //   return responseJson;
  // }

  // Future<dynamic> uploadFile(String url,File file,[int isPublic]) async{
  //
  //   if (file == null) return;
  //   String fileName = file.path.split("/").last;
  //
  //   Map<String, String> data = new Map<String, String>();
  //
  //   if(isPublic != null)
  //     data["is_public"] = isPublic.toString();
  //
  //   final SharedPref pref = Injector().get();
  //   String token = pref.getString(SharedPref.token);
  //
  //   Map<String, String> headers = new Map<String, String>();
  //   headers["Authorization"] = 'Bearer $token';
  //
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.files.add(
  //       http.MultipartFile.fromBytes(
  //           'image',
  //           File(file.path).readAsBytesSync(),
  //           filename: fileName
  //       )
  //   );
  //
  //   request.fields.addAll(data);
  //   request.headers.addAll(headers);
  //
  //   var res = await request.send();
  //   return res.statusCode;
  // }

  // Future<dynamic> uploadAttachment(String url,File file) async{
  //
  //   if (file == null) return;
  //   String fileName = file.path.split("/").last;
  //
  //   Map<String, String> data = <String, String>{};
  //
  //   Map<String, String> headers = <String, String>{};
  //   // headers["Authorization"] = 'Bearer $token';
  //
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.files.add(
  //       http.MultipartFile.fromBytes(
  //           'file',
  //           File(file.path).readAsBytesSync(),
  //           filename: fileName
  //       )
  //   );
  //
  //   request.fields.addAll(data);
  //   request.headers.addAll(headers);
  //
  //   var res = await request.send();
  //   return res.stream.bytesToString();
  // }
}
