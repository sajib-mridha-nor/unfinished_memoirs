import 'dart:developer';

import 'package:bongobondhu_app/core/utils/api_client.dart';
import 'package:bongobondhu_app/core/utils/urls.dart';

class LastViewedRepository {
  Future<void> updateLastView({
    required String lineSerial,
  }) async {
    final body = {'line_serial_id': lineSerial};
    try {
      final response = await ApiClient().postRequest(Urls.lastViewedUrl, body);
      log('last viewed response ${response.body}');
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      log('$e');
    }
  }
}
