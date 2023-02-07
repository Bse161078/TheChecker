import '../../src/controllers/basic.dart';
import 'package:get/get.dart';
import '../data/repository/main_repository.dart';

enum CheckMenuItems { floor, bed, shelves, curtains, bathroom }

class CheckListController extends Basic {
  static CheckListController get to => Get.find();

  final MainRepository repository;
  CheckListController({required this.repository});

  // floor items
  final floorRoomIsVacuumed = RxBool(false);
  final floorRoomIsVacuumedPhoto = RxList<String>([]);
  final floorRoomIsNotVacuumed = RxBool(false);
  final floorRoomIsNotVacuumedPhoto = RxList<String>([]);
  final floorHasStrongStainsCanNotBeCleaned = RxBool(false);
  final floorHasStrongStainsCanNotBeCleanedPhoto = RxList<String>([]);
  final floorDamageCausedByGuests = RxBool(false);
  final floorDamageCausedByGuestsPhoto = RxList<String>([]);
  final floorDamageReport = RxString('');
  final floorDamageReportPhoto = RxList<String>([]);

  Future<bool> updateFloorItems(roomId) async {
    await repository.floor(
        roomId,
        floorRoomIsVacuumed.value,
        floorRoomIsVacuumedPhoto,
        floorRoomIsNotVacuumed.value,
        floorRoomIsNotVacuumedPhoto,
        floorHasStrongStainsCanNotBeCleaned.value,
        floorHasStrongStainsCanNotBeCleanedPhoto,
        floorDamageCausedByGuests.value,
        floorDamageCausedByGuestsPhoto,
        floorDamageReport.value,
        floorDamageReportPhoto);
    return true;
  }

  // bed items
  final bedIsMadeUp = RxBool(false);
  final bedIsMadeUpPhoto = RxList<String>([]);
  final bedNotFresh = RxBool(false);
  final bedNotFreshPhoto = RxList<String>([]);
  final bedNotTightened = RxBool(false);
  final bedNotTightenedPhoto = RxList<String>([]);
  final bedExtraBed = RxBool(false);
  final bedExtraBedPhoto = RxList<String>([]);
  final bedDamageReport = RxString('');
  final bedDamageReportPhoto = RxList<String>([]);

  Future<bool> updateBedItems(roomId) async {
    await repository.bed(
        roomId,
        bedIsMadeUp.value,
        bedIsMadeUpPhoto,
        bedNotFresh.value,
        bedNotFreshPhoto,
        bedNotTightened.value,
        bedNotTightenedPhoto,
        bedExtraBed.value,
        bedExtraBedPhoto,
        bedDamageReport.value,
        bedDamageReportPhoto);
    return true;
  }

  // material items
  final materialWater = RxBool(false);
  final materialChips = RxBool(false);

  // bathroom items
  final bathroomIsCleaned = RxBool(false);
  final bathroomIsCleanedPhoto = RxList<String>([]);
  final bathroomTilesNotMopped = RxBool(false);
  final bathroomTilesNotMoppedPhoto = RxList<String>([]);
  final bathroomToiletNotWiped = RxBool(false);
  final bathroomToiletNotWipedPhoto = RxList<String>([]);
  final bathroomDirtInShower = RxBool(false);
  final bathroomDirtInShowerPhoto = RxList<String>([]);
  final bathroomShelvesNotWiped = RxBool(false);
  final bathroomShelvesNotWipedPhoto = RxList<String>([]);
  final bathroomTraysNotFilled = RxBool(false);
  final bathroomTraysNotFilledPhoto = RxList<String>([]);
  final bathroomDamageReport = RxString('');
  final bathroomDamageReportPhoto = RxList<String>([]);

  Future<bool> updateBathroomItems(roomId) async {
    await repository.bathroom(
        roomId,
        bathroomIsCleaned.value,
        bathroomIsCleanedPhoto,
        bathroomTilesNotMopped.value,
        bathroomTilesNotMoppedPhoto,
        bathroomToiletNotWiped.value,
        bathroomToiletNotWipedPhoto,
        bathroomDirtInShower.value,
        bathroomDirtInShowerPhoto,
        bathroomShelvesNotWiped.value,
        bathroomShelvesNotWipedPhoto,
        bathroomTraysNotFilled.value,
        bathroomTraysNotFilledPhoto,
        bathroomDamageReport.value,
        bathroomDamageReportPhoto);
    return true;
  }

  // curtains

  //
  //   bool topQuestionStatus,
  //   List<String> samplePhotoTopQuestion,
  //   bool curtainsNotCleanStatus,
  //   List<String> curtainsNotCleanPhotos,
  //   bool curtainsHaveWrinklesStatus,
  //   List<String> curtainsHaveWrinklesPhotos,
  //   String DamageReportText,
  //   List<String> DamageReportPhotos,

  final curtainsTopQuestion = RxBool(false);
  final curtainsTopQuestionPhoto = RxList<String>([]);
  final curtainsNotClean = RxBool(false);
  final curtainsNotCleanPhoto = RxList<String>([]);
  final curtainsHaveWrinkles = RxBool(false);
  final curtainsHaveWrinklesPhoto = RxList<String>([]);
  final curtainsDamageReport = RxString('');
  final curtainsDamageReportPhoto = RxList<String>([]);
  Future<bool> updateCurtainsItems(roomId) async {
    await repository.curtains(
        roomId,
        curtainsTopQuestion.value,
        curtainsTopQuestionPhoto,
        curtainsNotClean.value,
        curtainsNotCleanPhoto,
        curtainsHaveWrinkles.value,
        curtainsHaveWrinklesPhoto,
        curtainsDamageReport.value,
        curtainsDamageReportPhoto);
    return true;
  }

  // shelves
  final shelvesAllShelvesWiped = RxBool(false);
  final shelvesAllShelvesWipedPhoto = RxList<String>([]);
  final shelvesTable = RxBool(false);
  final shelvesTablePhoto = RxList<String>([]);
  final shelvesSideTable = RxBool(false);
  final shelvesSideTablePhoto = RxList<String>([]);
  final shelvesTV = RxBool(false);
  final shelvesTVPhoto = RxList<String>([]);
  final shelvesWindowSill = RxBool(false);
  final shelvesWindowSillPhoto = RxList<String>([]);
  final shelvesCabinetSurfaces = RxBool(false);
  final shelvesCabinetSurfacesPhoto = RxList<String>([]);
  final shelvesAllBrochuresNeatlySorted = RxBool(false);
  final shelvesAllBrochuresNeatlySortedPhoto = RxList<String>([]);
  final shelvesDamageReport = RxString('');
  final shelvesDamageReportPhoto = RxList<String>([]);

  Future<bool> updateShelvesItems(roomId) async {
    await repository.shelves(
        roomId,
        shelvesAllShelvesWiped.value,
        shelvesAllShelvesWipedPhoto,
        shelvesTable.value,
        shelvesTablePhoto,
        shelvesSideTable.value,
        shelvesSideTablePhoto,
        shelvesTV.value,
        shelvesTVPhoto,
        shelvesWindowSill.value,
        shelvesWindowSillPhoto,
        shelvesCabinetSurfaces.value,
        shelvesCabinetSurfacesPhoto,
        shelvesAllBrochuresNeatlySorted.value,
        shelvesAllBrochuresNeatlySortedPhoto,
        shelvesDamageReport.value,
        shelvesDamageReportPhoto);
    return true;
  }

  final currentCheckItem = Rx<CheckMenuItems>(CheckMenuItems.floor);
}
