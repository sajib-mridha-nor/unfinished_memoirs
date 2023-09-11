import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessTokenProvider extends ChangeNotifier {
  static AccessTokenProvider read(BuildContext context) =>
      context.read<AccessTokenProvider>();

  static AccessTokenProvider watch(BuildContext context) =>
      context.watch<AccessTokenProvider>();
  String? accessToken;
  bool _isLoggedIn = false;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    log('AccessTokenFromGet: $accessToken');
    if (accessToken == '' || accessToken == null) {
      _isLoggedIn = false;
    } else {
      _isLoggedIn = true;
    }
    print('adssadsadsad ${_isLoggedIn}');
    this.accessToken = accessToken;
    notifyListeners();
    return accessToken;
  }

  Future<void> setToken(String accessToken) async {
    log('accessTokenSet $accessToken');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    this.accessToken = accessToken;
    notifyListeners();
  }

  bool get isLoggedIn => _isLoggedIn;
}

class AuthViewWrapper extends StatefulWidget {
  final Widget child;

  const AuthViewWrapper({Key? key, required this.child}) : super(key: key);

  @override
  AuthViewWrapperState createState() => AuthViewWrapperState();
}

class AuthViewWrapperState extends State<AuthViewWrapper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccessTokenProvider>(
      builder: (context, vm, _child) =>
          SizedBox(key: Key(vm.accessToken ?? ''), child: widget.child),
    );
  }
}
