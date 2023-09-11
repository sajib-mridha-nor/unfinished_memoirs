import 'dart:convert';
import 'dart:developer';

import 'package:bongobondhu_app/core/utils/api_client.dart';
import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/core/utils/urls.dart';
import 'package:dartz/dartz.dart';

import '../model/bookmark_data_model.dart';

class BookmarkGetRepository {
  Future<Either<AppError, List<BookmarkDataModel>>> getData({
    required String languageId,
  }) async {
    try {
      final response = await ApiClient().getRequest(
        '${Urls.bookmarkUrl}?lang=$languageId',
      );
      log(response.body);
      if (response.statusCode == 200) {
        final data = bookmarkDataModelFromJson(utf8.decode(response.bodyBytes));
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
