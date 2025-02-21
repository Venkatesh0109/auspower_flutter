import 'package:flutter/material.dart';
import 'package:auspower_flutter/services/localization/language_strings.dart';
import 'package:auspower_flutter/services/localization/languages/ln_arabic.dart';
import 'package:auspower_flutter/services/localization/languages/ln_english.dart';
import 'package:auspower_flutter/services/localization/languages/ln_hindi.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<LanguageString> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar', 'hi'].contains(locale.languageCode);

  @override
  Future<LanguageString> load(Locale locale) => _load(locale);

  static Future<LanguageString> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'ar':
        return LanguageAr();
      case 'hi':
        return LanguageHi();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<LanguageString> old) => false;
}
