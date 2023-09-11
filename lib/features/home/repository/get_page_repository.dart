import 'dart:convert';
import 'dart:developer';

import 'package:bongobondhu_app/core/utils/api_client.dart';
import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/core/utils/urls.dart';
import 'package:bongobondhu_app/features/home/model/page_data_model.dart';
import 'package:dartz/dartz.dart';

class PageRepository {
  Future<Either<AppError, PageDataModel>> getData({
    required String languageId,
    required String chapter,
    required String pageNumber,
  }) async {
    try {
      final response = await ApiClient().getRequest(
        '${Urls.pageUrl}?lang=$languageId&page_number=$pageNumber&chapter_name=$chapter',
      );
      log(response.body);
      if (response.statusCode == 200) {
        final data = pageDataModelFromJson(utf8.decode(response.bodyBytes));
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
