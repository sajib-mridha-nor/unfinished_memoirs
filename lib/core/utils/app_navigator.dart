import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final appNavigator = _AppNavigator();

class _AppNavigator {
  final navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get context => navigatorKey.currentContext;

  T getProvider<T>() => Provider.of<T>(context!, listen: false);

  T getProviderListener<T>() => Provider.of<T>(context!);
}

class AppNavigator {
  ///navigate to particular page

  static Future<Object?>? push(Widget page) {
    return appNavigator.navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (context) => page));
  }

  ///replacement of a navigation

  static Future<Object?>? pushReplacement(Widget page) {
    return appNavigator.navigatorKey.currentState
        ?.pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  ///navigate and remove navigation

  static Future<Object?>? pushAndRemoveUntil(Widget page) {
    return appNavigator.navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (_) => false,
    );
  }

  ///navigator.pop

  static void pop() {
    return Navigator.pop(appNavigator.navigatorKey.currentContext!);
  }
}
