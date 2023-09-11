import 'dart:convert';
import 'dart:developer';

import 'package:bongobondhu_app/core/utils/api_client.dart';
import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/core/utils/urls.dart';
import 'package:bongobondhu_app/features/index/model/content_data_model.dart';
import 'package:dartz/dartz.dart';

class ContentRepository {
  Future<Either<AppError, List<ContentDataModel>>> getData({
    required String languageId,
  }) async {
    try {
      final response =
          await ApiClient().getRequest('${Urls.contentsUrl}?lang=$languageId');
      log(response.body);
      if (response.statusCode == 200) {
        final data = contentDataModelFromJson(utf8.decode(response.bodyBytes));

        return Right(data);
      } else {
        return const Left(AppError.httpError);
      }
    } catch (e) {
      log('$e');
      return const Left(AppError.serverError);
    }
  }
}
