import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';

loaderDialogBox(BuildContext context) {
  return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Scaffold(
              key: loaderDialogKey,
              backgroundColor: Colors.transparent,
              body: Center(
                  child: Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Palette.pureWhite,
                    boxShadow: ThemeGuide.primaryShadow),
                child: const CircularProgressIndicator(color: Palette.primary),
              ))),
        );
      });
}

void closeLaoderDialog() {
  Navigator.pop(loaderDialogKey.currentContext!);
}
