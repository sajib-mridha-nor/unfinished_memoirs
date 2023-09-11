import 'dart:convert';
import 'dart:developer';

import 'package:bongobondhu_app/core/utils/api_client.dart';
import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/core/utils/urls.dart';
import 'package:bongobondhu_app/features/profile/model/profile_model.dart';
import 'package:dartz/dartz.dart';

class ProfileGetRepository {
  Future<Either<AppError, ProfileModel>> getData() async {
    try {
      final response = await ApiClient().getRequest(
        Urls.profileGetUrl,
      );
      log(response.body);
      if (response.statusCode == 200) {
        final data = profileModelFromJson(utf8.decode(response.bodyBytes));
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
