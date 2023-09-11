import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreference {
  static const language = 'Language';

  Future<void> setLanguage(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(language, value);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(language) ?? 'en';
  }
}
