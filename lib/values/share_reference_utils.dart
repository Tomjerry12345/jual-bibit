import 'package:admin_qurban_mart/values/output_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  static final SharedPreferenceUtils _instance =
      SharedPreferenceUtils._internal();
  SharedPreferences? _prefs;
  bool _isInitialized = false;

  factory SharedPreferenceUtils() {
    return _instance;
  }

  SharedPreferenceUtils._internal() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  Future<void> setString(String key, String value) async {
    await _waitForInitialization();
    await _prefs?.setString(key, value);
    logO("saved sharePreference", m: value);
  }

  Future<String?> getString(String key) async {
    await _waitForInitialization();
    return _prefs?.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _waitForInitialization();
    await _prefs?.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    await _waitForInitialization();
    return _prefs?.getBool(key);
  }

  Future<void> _waitForInitialization() async {
    while (!_isInitialized) {
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  Future<void> printAllSharedPreferences() async {
    await _waitForInitialization();
    final allPrefs = _prefs?.getKeys(); // Mendapatkan semua kunci

    for (String key in allPrefs!) {
      final value = _prefs?.get(key); // Mendapatkan nilai berdasarkan kunci
      print('Key: $key, Value: $value');
    }
  }
}
