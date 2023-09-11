import 'dart:convert';
import 'dart:developer';

import 'package:bongobondhu_app/core/utils/api_client.dart';
import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/core/utils/urls.dart';
import 'package:bongobondhu_app/features/home/model/last_played_line_data_model.dart';
import 'package:dartz/dartz.dart';

class LastPlayedLineRepository {
  Future<Either<AppError, LastPlayedLineDataModel>> getData() async {
    try {
      final response = await ApiClient().getRequest(
        Urls.lastPlayedLineUrl,
      );
      log(response.body);
      if (response.statusCode == 200) {
        final data =
            lastPlayedLineDataModelFromJson(utf8.decode(response.bodyBytes));
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
