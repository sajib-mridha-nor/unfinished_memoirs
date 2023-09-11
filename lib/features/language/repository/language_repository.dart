import 'dart:developer';

import 'package:bongobondhu_app/core/utils/api_client.dart';
import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/core/utils/urls.dart';
import 'package:bongobondhu_app/features/language/model/language_model.dart';
import 'package:dartz/dartz.dart';

class LanguageRepository {
  Future<Either<AppError, List<LanguageModel>>> fetchLanguage() async {
    try {
      final response = await ApiClient().getRequest(Urls.languageUrl);

      if (response.statusCode == 200) {
        final language = languageModelFromJson(response.body);

        return Right(language);
      } else {
        return const Left(AppError.httpError);
      }
    } catch (c) {
      log('');
      return const Left(AppError.networkError);
    }
  }
}
