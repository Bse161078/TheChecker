import 'package:get/get.dart';

class Basic extends GetxController{

  Basic();

  final _isLoading = false.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) {
    _isLoading.value = value;
  }

  final _secondaryIsLoading = false.obs;
  get secondaryIsLoading => _secondaryIsLoading.value;
  set secondaryIsLoading(value) {
    _secondaryIsLoading.value = value;
  }

  final _hasException = false.obs;
  get hasException => _hasException.value;
  set hasException(value) {
    _hasException.value = value;
  }

  final _exception = ''.obs;
  get exception => _exception.value;
  set exception(value){
    _exception.value = value;
  }

}