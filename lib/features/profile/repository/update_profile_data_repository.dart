import 'package:bongobondhu_app/core/utils/app_error.dart';
import 'package:bongobondhu_app/core/utils/auth_wrapper.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ProfileUpdateRepository {
  Future<Either<AppError, bool>> updateData({
    required body,
    String? filePath,
  }) async {
    final accessToken = await AccessTokenProvider().getToken();
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest('POST',
        Uri.parse('https://bangabandhu.agrexcointernational.com/user/'));
    request.fields.addAll(body);
    if (filePath != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_pic',
          filePath,
        ),
      );
    }
    request.headers.addAll(headers);
    final response = await request.send();
    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left(AppError.networkError);
    }
  }
}
