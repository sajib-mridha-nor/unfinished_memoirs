import 'dart:convert';
import 'dart:developer';

import 'package:bongobondhu_app/core/utils/api_client.dart';
import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/core/utils/urls.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class SignupRepository {
  Future<Either<AppError, bool>> signup(
    Map<String, String> body,
  ) async {
    BotToast.showLoading();
    final l10n = Localize().l10n;
    try {
      final response = await ApiClient().postRequest(Urls.signupUrl, body);
      log('${response.statusCode}');
      if (response.statusCode == 201) {
        final res = json.decode(response.body);
        BotToast.closeAllLoading();
        BotToast.showText(
          text: l10n.signInSuccessfulText,
          contentColor: Colors.green,
        );
        return const Right(true);
      } else if (response.statusCode == 400) {
        final res = json.decode(response.body);
        BotToast.showText(
          text: res['email'][0] ?? '',
          contentColor: Colors.red,
        );
        BotToast.showText(
          text: res['username'][0] ?? '',
          contentColor: Colors.red,
        );
        BotToast.closeAllLoading();
        return const Left(AppError.httpError);
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
