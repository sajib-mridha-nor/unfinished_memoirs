import 'dart:developer';

import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/core/utils/language.dart';
import 'package:bongobondhu_app/core/utils/language_preference.dart';
import 'package:bongobondhu_app/features/language/model/language_model.dart';
import 'package:bongobondhu_app/features/language/repository/language_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageViewModel extends ChangeNotifier {
  static LanguageViewModel read(BuildContext context) =>
      context.read<LanguageViewModel>();

  static LanguageViewModel watch(BuildContext context) =>
      context.watch<LanguageViewModel>();

  List<LanguageModel> _languages = <LanguageModel>[];

  set languages(List<LanguageModel> v) {
    _languages = v;
    notifyListeners();
  }

  AppError? _appError;

  LanguageType _languageType = LanguageType.English;
  String? languageId;
  String? totalPage;
  bool _isLoading = false;
  set isLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<void> setLanguageID(String languageId) async {
    log('LanguageIdSet $languageId');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageId', languageId);
    this.languageId = languageId;
    notifyListeners();
  }

  Future<void> setTotalPage(String totalPage) async {
    log('totalPageSet $languageId');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('totalPage', totalPage);
    this.totalPage = totalPage;
    notifyListeners();
  }

  Future<String?> getLanguageID() async {
    final prefs = await SharedPreferences.getInstance();
    final languageId = prefs.getString('languageId');
    log('languageIdFromGet: $languageId');
    this.languageId = languageId;
    notifyListeners();
    return languageId;
  }

  Future<String?> getTotalPage() async {
    final prefs = await SharedPreferences.getInstance();
    final totalPage = prefs.getString('totalPage');
    log('languageIdFromGet: $languageId');
    this.totalPage = totalPage;
    notifyListeners();
    return totalPage;
  }

  Future<void> getLanguage() async {
    final _language = await LanguagePreference().getLanguage();
    _languageType =
        _language == 'en' ? LanguageType.English : LanguageType.Bangla;
    notifyListeners();
  }

  LanguageType get languageType => _languageType;

  Future<void> getLanguageData() async {
    _isLoading = true;
    final res = await LanguageRepository().fetchLanguage();
    res.fold((l) {
      _appError = l;
      _isLoading = false;
      notifyListeners();
    }, (r) {
      _languages = r;
      _isLoading = false;
      notifyListeners();
    });
  }

  List<LanguageModel> get languages => _languages;
  AppError? get appError => _appError;
  bool get isLoading => _isLoading;
}
