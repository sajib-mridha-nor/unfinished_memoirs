import 'dart:convert';
import 'dart:developer';

import 'package:bongobondhu_app/core/utils/api_client.dart';
import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/core/utils/urls.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class LoginRepository {
  Future<Either<AppError, String>> login(
    Map<String, String> body,
  ) async {
    BotToast.showLoading();
    final l10n = Localize().l10n;
    try {
      final response = await ApiClient().multiPartRequest(Urls.loginUrl, body);
      final responseBody = await response.stream.bytesToString();
      final decodedJson = json.decode(responseBody);
      log(responseBody);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        BotToast.showText(
          text: l10n.signInSuccessfulText,
          contentColor: Colors.green,
        );
        log(decodedJson['access']);
        return Right(decodedJson['access']);
      } else {
        BotToast.showText(
          text: '',
          contentColor: Colors.red,
        );
        BotToast.closeAllLoading();
        return const Left(AppError.httpError);
      }
    } catch (c) {
      log('');
      BotToast.closeAllLoading();
      return const Left(AppError.networkError);
    }
  }
}
