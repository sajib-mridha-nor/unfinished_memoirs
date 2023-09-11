import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/features/bookmark/model/bookmark_data_model.dart';
import 'package:bongobondhu_app/features/bookmark/repository/bookmark_post_repo.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/get_bookmark_repository.dart';

class BookmarkViewModel extends ChangeNotifier {
  static BookmarkViewModel read(BuildContext context) =>
      context.read<BookmarkViewModel>();

  static BookmarkViewModel watch(BuildContext context) =>
      context.watch<BookmarkViewModel>();

  AppError? _appError;
  List<BookmarkDataModel> _bookmarkList = [];
  bool _isLoading = false;
  set isLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<void> getBookmarkData() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final languageId = prefs.getString('languageId');
    final res = await BookmarkGetRepository().getData(
      languageId: languageId ?? '1',
    );
    res.fold((l) {
      isLoading = false;
      _bookmarkList = [];
      notifyListeners();
    }, (r) {
      _bookmarkList = r;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addBookmark({required String lineId}) async {
    isLoading = true;
    final body = {'line_serial': lineId};
    final res = await BookmarkPostRepository().addBookmark(body);
    res.fold((l) {
      _appError = l;
      isLoading = false;
      notifyListeners();
    }, (r) {
      isLoading = false;
      BotToast.showText(text: 'Added successfully');
      notifyListeners();
    });
  }

  AppError? get appError => _appError;
  bool get isLoading => _isLoading;
  List<BookmarkDataModel> get bookmarkList => _bookmarkList;
}
