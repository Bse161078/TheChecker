import 'dart:async';

import 'dart:io';

class EndUserException implements Exception{
  final Object _msg;
  EndUserException(this._msg);

  @override
  String toString() {
    return '$_msg';
  }
}

class ApiException implements Exception {

  final Object _ex;

  ApiException(this._ex);

  String get reason {
    if(_ex is TimeoutException){
      return 'TimedOut';
    } else if(_ex is SocketException){
      return 'No Internet connection';
    } else if(_ex is HttpException){
      return 'Couldn\'t find the request';
    } else if(_ex is FormatException){
      return 'Bad response format';
    } else if(_ex is EndUserException){
      return _ex.toString();
    }else {
      return 'An error occurred in the request';
    }
  }

  @override
  String toString() {
    return 'Error: $reason';
  }
}
