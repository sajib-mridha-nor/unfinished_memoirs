import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  static late SharedPreferences _sharedPrefs;
  // static late String languageKey = 'language';

  factory SharedPrefsManager() => SharedPrefsManager._internal();

  SharedPrefsManager._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  // String get getLanguage => _sharedPrefs.getString(languageKey) ?? 'en';
  //
  // set getLanguage(String language) {
  //   _sharedPrefs.setString(languageKey, language);
  // }
}
