
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RoleType{
  Checker,Reception
}

class Pref {

  static Pref get to => Get.find();
  late SharedPreferences _instance;

  static const token = "token";
  static const role = "role";
  static const name = "name";
  static const id = "id";

  Future<Pref> init() async {
    _instance = await SharedPreferences.getInstance();
    return this;
  }

  String get tokenVal => _instance.getString(Pref.token) ?? '';
  String get roleVal => _instance.getString(Pref.role) ?? '';
  String get nameVal => _instance.getString(Pref.name) ?? '';
  String get idVal => _instance.getString(Pref.id) ?? '';

  getString(String _key) {
    return _instance.getString(_key) ?? '';
  }

  Future setString(String _key,String _value) async {
    return await _instance.setString(_key, _value);
  }

  Future setInt(String _key,int _value) async {
    return await _instance.setInt(_key, _value);
  }

  getInt(String _key) {
    return _instance.getInt(_key) ?? 0;
  }

  void clear() {
    _instance.clear();
  }

}