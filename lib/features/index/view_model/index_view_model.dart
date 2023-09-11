import 'package:bongobondhu_app/features/index/model/content_data_model.dart';
import 'package:bongobondhu_app/features/index/repository/get_content_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexViewModel with ChangeNotifier {
  static IndexViewModel read(BuildContext context) =>
      context.read<IndexViewModel>();

  static IndexViewModel watch(BuildContext context) =>
      context.watch<IndexViewModel>();
  bool _isLoading = false;
  List<ContentDataModel> _contentList = [];

  set isLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<void> getContentData() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final languageId = prefs.getString('languageId');
    final res =
        await ContentRepository().getData(languageId: languageId ?? '1');
    res.fold((l) {
      isLoading = false;
      notifyListeners();
    }, (r) {
      _contentList = r;
      isLoading = false;
      notifyListeners();
    });
  }

  bool get isLoading => _isLoading;
  List<ContentDataModel> get contentList => _contentList;
}
