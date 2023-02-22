import 'package:checkerapp/src/data/model/material_model.dart';

import '../../src/controllers/basic.dart';
import 'package:get/get.dart';

import '../data/model/room_model.dart';
import '../data/repository/main_repository.dart';
import '../network/response.dart';
import '../utils/utils.dart';

class MaterialsController extends Basic {
  static MaterialsController get to => Get.find();

  final MainRepository repository;
  MaterialsController({required this.repository});

  final materialList = RxList<Material>([]);

  // order items
  final orderHotelManagement = RxBool(false);
  final orderCleaningCompany = RxBool(false);

  getMaterials() async {
    try {
      isLoading = true;
      ApiResponse result = await repository.materials();
      final list = result.body['data']['materials'];
      materialList.value = Material.fromJsonList(list);
      log(this, 'material list ${list.length}');
    } catch (e) {
      log(this, e);
    } finally {
      isLoading = false;
    }
  }

  saveMaterials() async {
    try {
      if (secondaryIsLoading) {
        return;
      }
      secondaryIsLoading = true;

      String supplier = 'company';
      if (orderHotelManagement.value) {
        supplier = 'hotel';
      }
      ApiResponse result = await repository.setMaterial(materialList, supplier);
      log(this, 'material set ${result.status}');
      Get.back();
      Get.back();
      Toast.success('request_submitted'.tr, 'order'.tr);
    } catch (e) {
      log(this, e);
    } finally {
      secondaryIsLoading = false;
    }
  }
}
