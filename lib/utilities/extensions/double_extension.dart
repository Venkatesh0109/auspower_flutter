import 'package:flutter/material.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';

extension DoubleExtension on double {
  /// returns the given font size when the screen is mobile
  ///
  /// returns 1.25 multiples of the given font size when the screen is tablet.
  ///
  /// returns 1.29 multiples of the given font size when the screen is desktop.
  double getFontSize(BuildContext context) {
    double fontSize = this;
    if (context.isTablet()) {
      fontSize *= 1.25;
    }
    if (context.isDesktop()) {
      fontSize *= 1.29;
    }
    return fontSize;
  }
}
