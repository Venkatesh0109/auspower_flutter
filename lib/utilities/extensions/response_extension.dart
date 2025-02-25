import 'package:auspower_flutter/models/response.dart';

extension ResponseExtension on ResponseData {
  bool get hasError {
    if (!data["iserror"]) {
      return false;
    }
    if (data["iserror"]) return true;
    // String errMsg = data['message'] ?? '';
    // if (errMsg.isNotEmpty) showMessage(errMsg);
    return true;
  }
}
