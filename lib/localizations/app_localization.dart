import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;
  Map<String, String> _jsonMap;
  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();

  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  Future load() async {
    Map<String, dynamic> jsonDynamic = json.decode(
      await rootBundle.loadString('lang/${locale.languageCode}.json'),
    );
    _jsonMap = jsonDynamic.map((key, value) => MapEntry(key, value.toString()));
  }

  String getText(String key) => _jsonMap[key];
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}
