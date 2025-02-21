import 'package:flutter/material.dart';

abstract class LanguageString {
  static LanguageString? of(BuildContext context) {
    return Localizations.of<LanguageString>(context, LanguageString);
  }

  String get appName;

  String get labelWelcome;

  String get labelInfo;

  String get labelSelectLanguage;
}
