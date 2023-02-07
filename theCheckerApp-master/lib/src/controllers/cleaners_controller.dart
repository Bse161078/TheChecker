import '../data/model/cleaner_model.dart';
import '../../src/controllers/basic.dart';
import 'package:get/get.dart';
import '../data/repository/main_repository.dart';
import '../network/response.dart';
import '../utils/logger.dart';

class CleanersController extends Basic {
  static CleanersController get to => Get.find();

  final MainRepository repository;
  CleanersController({required this.repository});

  final cleanersList = RxList<Cleaner>([]);

  getCleaners() async {
    try {
      isLoading = true;

      ApiResponse result = await repository.cleaners();
      final list = result.body['data']['cleaners'];
      cleanersList.value = Cleaner.fromJsonList(list);
      log(this, 'cleaners list ${list.length}');
    } catch (e) {
      log(this, e);
    } finally {
      isLoading = false;
    }
  }
}
