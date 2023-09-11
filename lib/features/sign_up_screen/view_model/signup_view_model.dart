import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/features/sign_up_screen/repository/signup_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupViewModel extends ChangeNotifier {
  static SignupViewModel read(BuildContext context) =>
      context.read<SignupViewModel>();

  static SignupViewModel watch(BuildContext context) =>
      context.watch<SignupViewModel>();

  bool _passwordVisible = false;
  bool isSignup = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  AppError? _appError;

  set passwordVisible(bool value) {
    _passwordVisible = value;
    notifyListeners();
  }

  set emailController(TextEditingController value) {
    _emailController = value;
    notifyListeners();
  }

  set userNameController(TextEditingController value) {
    _userNameController = value;
    notifyListeners();
  }

  set passwordController(TextEditingController value) {
    _passwordController = value;
    notifyListeners();
  }

  set confirmPasswordController(TextEditingController value) {
    _confirmPasswordController = value;
    notifyListeners();
  }

  set firstNameController(TextEditingController value) {
    _firstNameController = value;
    notifyListeners();
  }

  set lastNameController(TextEditingController value) {
    _lastNameController = value;
    notifyListeners();
  }

  Future<void> getSignUp(Map<String, String> body) async {
    final res = await SignupRepository().signup(body);
    await res.fold((l) {
      _appError = l;
      isSignup = false;
      notifyListeners();
    }, (r) async {
      isSignup = true;

      notifyListeners();
    });
  }

  bool get passwordVisible => _passwordVisible;

  TextEditingController get emailController => _emailController;

  TextEditingController get userNameController => _userNameController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  TextEditingController get firstNameController => _firstNameController;

  TextEditingController get lastNameController => _lastNameController;

  AppError? get appError => _appError;
}
