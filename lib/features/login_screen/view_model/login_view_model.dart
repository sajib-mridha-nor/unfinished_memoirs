import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/core/utils/auth_wrapper.dart';
import 'package:bongobondhu_app/features/login_screen/repository/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  static LoginViewModel read(BuildContext context) =>
      context.read<LoginViewModel>();

  static LoginViewModel watch(BuildContext context) =>
      context.watch<LoginViewModel>();

  bool _passwordVisible = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AppError? _appError;

  set passwordVisible(bool value) {
    _passwordVisible = value;
    notifyListeners();
  }

  set emailController(TextEditingController value) {
    _emailController = value;
    notifyListeners();
  }

  set passwordController(TextEditingController value) {
    _passwordController = value;
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    if (accessToken == '' || accessToken == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> getLogin(Map<String, String> body) async {
    final res = await LoginRepository().login(body);

    await res.fold((l) {
      _appError = l;
      notifyListeners();
    }, (r) async {
      await AccessTokenProvider().setToken(r);
      await AccessTokenProvider().getToken();
      notifyListeners();
    });
  }

  bool get passwordVisible => _passwordVisible;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  AppError? get appError => _appError;
}
