import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  static const _fieldName = 'field';

  static SharedPreferences? _prefs;

  static Future<SharedPreferencesProvider> getInstance() async {
    _prefs = await SharedPreferences.getInstance();
    return SharedPreferencesProvider._();
  }

  SharedPreferencesProvider._();

  Future<void> saveField(String value) async {
    await _prefs?.setString(_fieldName, value);
  }

  String? get fieldValue => _prefs?.getString(_fieldName);
}

late SharedPreferencesProvider sharedPreferences;
