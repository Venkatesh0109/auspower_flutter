import 'package:dio/dio.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/models/response.dart';
import 'package:auspower_flutter/services/storage/storage_constants.dart';
import 'package:auspower_flutter/utilities/message.dart';
import 'package:flutter/material.dart';

class APIHelper {
  ResponseData httpErrorHandle(BuildContext context,
      {required Response? response}) {
    final dynamic responseData = response?.data;
    final int statusCode = response?.statusCode ?? 500;

    if (responseData is List && responseData.isNotEmpty) {
      final data = responseData[0];
      bool isError = data["iserror"] ?? true;
      String message = data["message"] ?? 'Unknown error';

      if (isError) {
        showMessage(message, duration: const Duration(seconds: 3));
      }
    } else if (responseData is Map) {
      // bool isError = responseData["iserror"] ?? true;
      // String message = responseData["message"] ?? 'Unknown error';

      // showMessage(message);
    } else {
      showMessage("Unexpected response format");

      // showMessage1('Unexpected response format',
      //     duration: const Duration(seconds: 3));
    }

    bool isError = responseData is List
        ? (responseData[0]["iserror"] ?? true)
        : (responseData is Map ? responseData["isrror"] ?? true : true);

    return ResponseData(
      data: responseData is List && responseData.isNotEmpty
          ? responseData[0]
          : (responseData is Map ? responseData : {}),
      statusCode: statusCode,
      isError: isError,
    );
  }

  Future<void> handleUnauthorized() async {
    return storage.delete(key: StorageConstants.accessToken).then((value) {});
  }
}
