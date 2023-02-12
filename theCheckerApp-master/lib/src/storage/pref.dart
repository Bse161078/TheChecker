import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RoleType { Checker, Reception }

class Pref {
  static Pref get to => Get.find();
  late SharedPreferences _instance;

  static const token = "token";
  static const role = "role";
  static const name = "name";
  static const id = "id";

  static const userAvatar = "avatar";
  static const hotelLogoChecker = "hotelLogoChecker";

  Future<Pref> init() async {
    _instance = await SharedPreferences.getInstance();
    return this;
  }

  String get tokenVal => _instance.getString(Pref.token) ?? '';
  String get roleVal => _instance.getString(Pref.role) ?? '';
  String get nameVal => _instance.getString(Pref.name) ?? '';
  String get idVal => _instance.getString(Pref.id) ?? '';

  String get userAvatarVal => _instance.getString(Pref.userAvatar) ?? '';
  String get hotelLogoCheckerVal =>
      _instance.getString(Pref.hotelLogoChecker) ?? '';

  getString(String key) {
    return _instance.getString(key) ?? '';
  }

  Future setString(String key, String value) async {
    return await _instance.setString(key, value);
  }

  Future setInt(String key, int value) async {
    return await _instance.setInt(key, value);
  }

  getInt(String key) {
    return _instance.getInt(key) ?? 0;
  }

  void clear() {
    _instance.clear();
  }
}
