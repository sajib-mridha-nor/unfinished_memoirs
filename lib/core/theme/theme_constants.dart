import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const _lightColorScheme = ColorScheme(
    background: whiteColor,
    brightness: Brightness.light,
    error: whiteColor,
    onBackground: whiteColor,
    onError: whiteColor,
    onPrimary: whiteColor,
    onSecondary: whiteColor,
    onSurface: whiteColor,
    primary: whiteColor,
    secondary: whiteColor,
    surface: whiteColor,
  );

  static const _darkColorScheme = ColorScheme(
    background: darkScaffoldColor,
    brightness: Brightness.dark,
    error: darkScaffoldColor,
    onBackground: darkScaffoldColor,
    onError: darkScaffoldColor,
    onPrimary: darkScaffoldColor,
    onSecondary: darkScaffoldColor,
    onSurface: whiteColor,
    primary: darkScaffoldColor,
    secondary: darkScaffoldColor,
    surface: darkScaffoldColor,
  );

  static final ThemeData lightTheme = ThemeData(
    primaryColor: lightBackgroundColor,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: lightBackgroundColor),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: lightBackgroundColor,
      iconTheme: IconThemeData(color: blackColor),
      titleTextStyle: TextStyle(color: blackColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: lightBackgroundColor,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: blackColor, // Change this to the desired color
      selectionColor: Colors.green,
      selectionHandleColor: Colors.orange,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightWhiteColor, // Replace with your desired color
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyles.regular14,
    ),
    colorScheme: _lightColorScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: kPrimaryColor,
      headerBackgroundColor: kPrimaryColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: whiteColor,
    scaffoldBackgroundColor: darkScaffoldColor,
    brightness: Brightness.dark,
    canvasColor: darkScaffoldColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: whiteColor),
    appBarTheme: const AppBarTheme(
      color: darkScaffoldColor,
      iconTheme: IconThemeData(color: whiteColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: darkScaffoldColor,
        systemNavigationBarDividerColor: darkScaffoldColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: whiteColor, // Change this to the desired color
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff434343), // Replace with your desired color
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyles.regular14White,
    ),
    iconTheme: const IconThemeData(color: whiteColor),
    colorScheme: _darkColorScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kDarkPrimaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: kDarkPrimaryColor,
    ),
  );
}
