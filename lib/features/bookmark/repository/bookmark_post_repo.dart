import 'dart:convert';
import 'dart:developer';

import 'package:bongobondhu_app/core/utils/api_client.dart';
import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/core/utils/urls.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class BookmarkPostRepository {
  Future<Either<AppError, bool>> addBookmark(
    Map<String, String> body,
  ) async {
    BotToast.showLoading();
    final l10n = Localize().l10n;
    try {
      final response = await ApiClient().postRequest(Urls.bookmarkUrl, body);
      log('${response.statusCode}');
      if (response.statusCode == 201) {
        final res = json.decode(response.body);
        BotToast.closeAllLoading();
        return const Right(true);
      } else {
        BotToast.showText(
          text: 'Something wrong, try again',
          contentColor: Colors.red,
        );
        BotToast.closeAllLoading();
        return const Left(AppError.httpError);
      }
    } catch (c) {
      log('');
      BotToast.closeAllLoading();
      BotToast.showText(
        text: 'Something wrong, try again',
        contentColor: Colors.red,
      );
      return const Left(AppError.networkError);
    }
  }
}
