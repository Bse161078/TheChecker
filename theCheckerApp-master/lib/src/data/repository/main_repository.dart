// ignore_for_file: non_constant_identifier_names

import 'package:checkerapp/src/network/response.dart';
import 'package:dio/dio.dart';

import '../../network/helper.dart';
import '../../network/routes.dart';
import '../../storage/pref.dart';
import '../../utils/logger.dart';
import '../model/material_model.dart';

class MainRepository {
  MainRepository();

  Future<dynamic> login(String userName, String password) async {
    var data = {
      "username": userName,
      "password": password,
    };
    final response =
        await ServiceProvider.execute(Routes.login, Method.POST, data, [200]);
    return response;
  }

  Future<dynamic> profile() async {
    final response =
        await ServiceProvider.execute(Routes.profile, Method.GET, null, [200]);
    return response;
  }

  Future<dynamic> rooms() async {
    final response =
        await ServiceProvider.execute(Routes.room, Method.GET, null, [200]);
    return response;
  }

  Future<dynamic> cleaners() async {
    final response =
        await ServiceProvider.execute(Routes.cleaner, Method.GET, null, [200]);
    return response;
  }

  Future<dynamic> setRoomStatus(
      String roomId, String status, String occupationStatus) async {
    var data = {
      "roomId": roomId,
      "clean_status": status,
      "occupation_status": occupationStatus,
    };
    print("Data is $data");
    final response = await ServiceProvider.execute(
        Routes.set_room_status, Method.POST, data, [200, 201]);
    return response;
  }

  Future<dynamic> sendAlert(String roomId, List<String> status) async {
    var data = {
      "roomID": roomId,
      "status": status,
    };
    print(status);
    final response = await ServiceProvider.execute(
        Routes.send_alert, Method.POST, data, [200, 201]);
    return response;
  }

  Future<dynamic> materials() async {
    final response = await ServiceProvider.execute(
        Routes.materials, Method.GET, null, [200]);
    return response;
  }

  Future<dynamic> setMaterial(List<Material> materials, String supplier) async {
    late ApiResponse response;

    for (int i = 0; i < materials.length; i++) {
      print("${materials[i].name!} ${materials[i].quantity} $supplier");
      var id = materials[i].id;
      var data = {
        "quantity": int.parse(materials[i].quantity.toString()),
        "emailTo": supplier,
      };

      response = await ServiceProvider.execute(
          "${Routes.materials}/$id/order", Method.POST, data, [200, 201]);
      print(response.body);
    }
    return response;
  }

  Future<dynamic> floor(
      roomId,
      bool topQuestionStatus,
      List<String> samplePhotoTopQuestion,
      bool roomIsNotVacuumedStatus,
      List<String> roomIsNotVacuumedPhotos,
      bool roomHasStrongStainsThatCanNotBeCleanedByUsStatus,
      List<String> roomHasStrongStainsThatCanNotBeCleanedByUsPhotos,
      bool DamageCausedByGuestsStatus,
      List<String> DamageCausedByGuestsPhotos,
      String DamageReportText,
      List<String> DamageReportPhotos) async {
    var url = '${Routes.baseURL}/room/$roomId/mistakes';

    log(this, 'floor data url $url');

    var dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer ${Pref.to.tokenVal}';

    final formData = FormData.fromMap({
      // "topQuestionStatus": topQuestionStatus,
      // "samplePhotoTopQuestion": [
      //   if (samplePhotoTopQuestion.isNotEmpty)
      //     await MultipartFile.fromFile(samplePhotoTopQuestion.last)
      //   // for (var filePath in samplePhotoTopQuestion)
      //   //   await MultipartFile.fromFile(filePath),
      // ],
      "roomIsNotVacuumedStatus": roomIsNotVacuumedStatus,
      "roomIsNotVacuumedPhotos": [
        if (roomIsNotVacuumedPhotos.isNotEmpty)
          await MultipartFile.fromFile(roomIsNotVacuumedPhotos.last)

        // for (var filePath in roomIsNotVacuumedPhotos)
        //   await MultipartFile.fromFile(filePath),
      ],
      "roomHasStrongStainsThatCanNotBeCleanedByUsStatus":
          roomHasStrongStainsThatCanNotBeCleanedByUsStatus,
      "roomHasStrongStainsThatCanNotBeCleanedByUsPhotos": [
        if (roomHasStrongStainsThatCanNotBeCleanedByUsPhotos.isNotEmpty)
          await MultipartFile.fromFile(
              roomHasStrongStainsThatCanNotBeCleanedByUsPhotos.last)
        // for (var filePath in roomHasStrongStainsThatCanNotBeCleanedByUsPhotos)
        //   await MultipartFile.fromFile(filePath),
      ],
      "damageCausedByGuestsStatus": DamageCausedByGuestsStatus,
      "damageCausedByGuestsPhotos": [
        if (DamageCausedByGuestsPhotos.isNotEmpty)
          await MultipartFile.fromFile(DamageCausedByGuestsPhotos.last)
        // for (var filePath in DamageCausedByGuestsPhotos)
        //   await MultipartFile.fromFile(filePath),
      ],
      "reportStatus": true,
      "reportPhotos": [
        if (DamageReportPhotos.isNotEmpty)
          await MultipartFile.fromFile(DamageReportPhotos.last)
        // for (var filePath in DamageReportPhotos)
        //   await MultipartFile.fromFile(filePath),
      ],
    });

    // print all data in formData
    for (var element in formData.fields) {
      print(element);
    }

    try {
      final response = await dio.post(url, data: formData);
      log(this, 'floor data  status ${response.statusCode}');
      log(this, 'floor data  body ${response.data}');
    } catch (e) {
      log(this, 'Error While Posting Floor Data:  $e');
    }

    return true;
  }

  Future<dynamic> bed(
    roomId,
    bool bedIsMadeUp,
    List<String> bedIsMadeUpPhoto,
    bool bedNotFresh,
    List<String> bedNotFreshPhoto,
    bool bedNotTightened,
    List<String> bedNotTightenedPhoto,
    bool bedExtraBed,
    List<String> bedExtraBedPhoto,
    String bedDamageReport,
    List<String> bedDamageReportPhoto,
  ) async {
    var url = '${Routes.bed}/$roomId';

    log(this, 'floor data url $url');

    var dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer ${Pref.to.tokenVal}';

    final formData = FormData.fromMap({
      "topQuestionStatus": bedIsMadeUp,
      "samplePhotoTopQuestion": [
        for (var filePath in bedIsMadeUpPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "bedDoesNotLookFreshStatus": bedNotFresh,
      "bedDoesNotLookFreshPhotos": [
        for (var filePath in bedNotFreshPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "bedSheetInNotProperlyTightenedStatus": bedNotTightened,
      "bedSheetInNotProperlyTightenedPhotos": [
        for (var filePath in bedNotTightenedPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "extraBedStatus": bedExtraBed,
      "extraBedPhotos": [
        for (var filePath in bedExtraBedPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "DamageReportText": bedDamageReport,
      "DamageReportPhotos": [
        for (var filePath in bedDamageReportPhoto)
          await MultipartFile.fromFile(filePath),
      ],
    });

    try {
      final response = await dio.post(url, data: formData);
      log(this, 'bed data  status ${response.statusCode}');
      log(this, 'bed data  body ${response.data}');
    } catch (e) {
      log(this, 'z $e');
    }

    return true;
  }

  Future<dynamic> shelves(
    roomId,
    bool shelvesAllShelvesWiped,
    List<String> shelvesAllShelvesWipedPhoto,
    bool shelvesTable,
    List<String> shelvesTablePhoto,
    bool shelvesSideTable,
    List<String> shelvesSideTablePhoto,
    bool shelvesTV,
    List<String> shelvesTVPhoto,
    bool shelvesWindowSill,
    List<String> shelvesWindowSillPhoto,
    bool shelvesCabinetSurfaces,
    List<String> shelvesCabinetSurfacesPhoto,
    bool shelvesAllBrochuresNeatlySorted,
    List<String> shelvesAllBrochuresNeatlySortedPhoto,
    String shelvesDamageReport,
    List<String> shelvesDamageReportPhoto,
  ) async {
    var url = '${Routes.shelves}/$roomId';

    log(this, 'floor data url $url');

    var dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer ${Pref.to.tokenVal}';

    final formData = FormData.fromMap({
      "topQuestionStatus": shelvesAllShelvesWiped,
      "samplePhotoTopQuestion": [
        for (var filePath in shelvesAllShelvesWipedPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "tableNotCleanStatus": shelvesTable,
      "tableNotCleanPhotos": [
        for (var filePath in shelvesTablePhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "sideTableNotCleanStatus": shelvesSideTable,
      "sideTableNotCleanPhotos": [
        for (var filePath in shelvesSideTablePhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "tvStandNotCleanStatus": shelvesTV,
      "tvStandNotCleanPhotos": [
        for (var filePath in shelvesTVPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "cabinetTopAndInsideSurfacesNotCleanStatus": shelvesCabinetSurfaces,
      "cabinetTopAndInsideSurfacesNotCleanPhotos": [
        for (var filePath in shelvesCabinetSurfacesPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "windowSillNotCleanStatus": shelvesWindowSill,
      "windowSillNotCleanPhotos": [
        for (var filePath in shelvesWindowSillPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "BrochuresNotNeatlyAndSortedInTheirPlaceStatus":
          shelvesAllBrochuresNeatlySorted,
      "BrochuresNotNeatlyAndSortedInTheirPlacePhotos": [
        for (var filePath in shelvesAllBrochuresNeatlySortedPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "DamageReportText": shelvesDamageReport,
      "DamageReportPhotos": [
        for (var filePath in shelvesDamageReportPhoto)
          await MultipartFile.fromFile(filePath),
      ],
    });

    try {
      final response = await dio.post(url, data: formData);
      log(this, 'shelves data  status ${response.statusCode}');
      log(this, 'shelves data  body ${response.data}');
    } catch (e) {
      log(this, 'z $e');
    }

    return true;
  }

  /// curtains

// topQuestionStatus
// bool
// samplePhotoTopQuestion
// array
// curtainsNotCleanStatus
// boolean
// curtainsNotCleanPhotos
// array
// curtainsHaveWrinklesStatus
// boolean
// curtainsHaveWrinklesPhotos
// array
// DamageReportText
// string
// DamageReportPhotos
// array

  Future<dynamic> curtains(
    roomId,
    bool topQuestionStatus,
    List<String> samplePhotoTopQuestion,
    bool curtainsNotCleanStatus,
    List<String> curtainsNotCleanPhotos,
    bool curtainsHaveWrinklesStatus,
    List<String> curtainsHaveWrinklesPhotos,
    String DamageReportText,
    List<String> DamageReportPhotos,
  ) async {
    var url = '${Routes.curtains}/$roomId';

    log(this, 'curtains data url $url');

    var dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer ${Pref.to.tokenVal}';

    final formData = FormData.fromMap({
      "topQuestionStatus": topQuestionStatus,
      "samplePhotoTopQuestion": [
        for (var filePath in samplePhotoTopQuestion)
          await MultipartFile.fromFile(filePath),
      ],
      "curtainsNotCleanStatus": curtainsNotCleanStatus,
      "curtainsNotCleanPhotos": [
        for (var filePath in curtainsNotCleanPhotos)
          await MultipartFile.fromFile(filePath),
      ],
      "curtainsHaveWrinklesStatus": curtainsHaveWrinklesStatus,
      "curtainsHaveWrinklesPhotos": [
        for (var filePath in curtainsHaveWrinklesPhotos)
          await MultipartFile.fromFile(filePath),
      ],
      "DamageReportText": DamageReportText,
      "DamageReportPhotos": [
        for (var filePath in DamageReportPhotos)
          await MultipartFile.fromFile(filePath),
      ],
    });

    try {
      final response = await dio.post(url, data: formData);
      log(this, 'curtains data  status ${response.statusCode}');
      log(this, 'curtains data  body ${response.data}');
    } on DioError catch (e) {
      log(this, 'dio c err: ${e.response?.statusMessage}');
      log(this, 'dio c err: ${e.error}');
    } catch (e) {
      log(this, '$this Curtains Post Request Error $e');
    }

    return true;
  }

  Future<dynamic> bathroom(
    roomId,
    bool bathroomIsCleaned,
    List<String> bathroomIsCleanedPhoto,
    bool bathroomTilesNotMopped,
    List<String> bathroomTilesNotMoppedPhoto,
    bool bathroomToiletNotWiped,
    List<String> bathroomToiletNotWipedPhoto,
    bool bathroomDirtInShower,
    List<String> bathroomDirtInShowerPhoto,
    bool bathroomShelvesNotWiped,
    List<String> bathroomShelvesNotWipedPhoto,
    bool bathroomTraysNotFilled,
    List<String> bathroomTraysNotFilledPhoto,
    String bathroomDamageReport,
    List<String> bathroomDamageReportPhoto,
  ) async {
    var url = '${Routes.bathroom}/$roomId';

    log(this, 'bathroom data url $url');

    var dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer ${Pref.to.tokenVal}';

    final formData = FormData.fromMap({
      "topQuestionStatus": bathroomIsCleaned,
      "samplePhotoTopQuestion": [
        for (var filePath in bathroomIsCleanedPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "tilesAreNotMoppedStatus": bathroomTilesNotMopped,
      "tilesAreNotMoppedPhotos": [
        for (var filePath in bathroomTilesNotMoppedPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "toiletIsNotWipedStatus": bathroomToiletNotWiped,
      "toiletIsNotWipedPhotos": [
        for (var filePath in bathroomToiletNotWipedPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "thereIsDirtInTheShoweStatus": bathroomDirtInShower,
      "thereIsDirtInTheShowePhotos": [
        for (var filePath in bathroomDirtInShowerPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "shelvesAreNotWipedStatus": bathroomShelvesNotWiped,
      "shelvesAreNotWipedPhotos": [
        for (var filePath in bathroomShelvesNotWipedPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "traysAreNotFilledStatus": bathroomTraysNotFilled,
      "traysAreNotFilledPhotos": [
        for (var filePath in bathroomTraysNotFilledPhoto)
          await MultipartFile.fromFile(filePath),
      ],
      "DamageReportText": bathroomDamageReport,
      "DamageReportPhotos": [
        for (var filePath in bathroomDamageReportPhoto)
          await MultipartFile.fromFile(filePath),
      ],
    });

    try {
      final response = await dio.post(url, data: formData);
      log(this, 'bathroom data  status ${response.statusCode}');
      log(this, 'bathroom data  body ${response.data}');
    } on DioError catch (e) {
      log(this, 'dio c err: ${e.response?.statusMessage}');
      log(this, 'dio c err: ${e.error}');
    } catch (e) {
      log(this, '$this Bathroom Post Request Error: $e');
    }

    return true;
  }
}
