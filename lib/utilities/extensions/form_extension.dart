import 'package:flutter/material.dart';

extension FormExtension on GlobalKey<FormState> {
  bool get hasError {
    bool hasNoError = currentState?.validate() ?? false;
    return !hasNoError;
  }
}
