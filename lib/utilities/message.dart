import 'package:flutter/material.dart';
import 'package:auspower_flutter/common/widgets/text.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/theme/palette.dart';

showMessage(String message, {Duration duration = const Duration(seconds: 1)}) {
  return snackbarKey.currentState
    ?..hideCurrentSnackBar
    ..showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: Palette.dark,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(SizeUnit.lg),
        content: TextCustom(
          message,
          fontWeight: FontWeight.bold,
          color: Palette.pureWhite,
        ),
      ),
    );
}

showToastMessage(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
}
