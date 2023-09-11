import 'package:bongobondhu_app/core/theme/theme_preferance.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeManagerViewModel with ChangeNotifier {
  static ThemeManagerViewModel read(BuildContext context) =>
      context.read<ThemeManagerViewModel>();

  static ThemeManagerViewModel watch(BuildContext context) =>
      context.watch<ThemeManagerViewModel>();

  ThemeType _themeType = ThemeType.Light;
  ThemeType get themeType => _themeType;

  bool _isDark = false;

  set isDark(bool v) {
    _isDark = v;
    ThemePreference().setDarkTheme(v);
    toggleTheme(isDark: v);
    notifyListeners();
  }

  getTheme() async {
    _isDark = await ThemePreference().getTheme();
    notifyListeners();
  }

  bool get isDark => _isDark;

  toggleTheme({required bool isDark}) {
    _themeType = isDark ? ThemeType.Dark : ThemeType.Light;
    notifyListeners();
  }

  // set darkTheme(bool value) {
  //   _darkTheme = value;
  //   darkThemePreference.setDarkTheme(value);
  //   notifyListeners();
  // }
}
