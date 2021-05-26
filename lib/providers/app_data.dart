import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/enumerations.dart';
import '../main.dart';

class AppData with ChangeNotifier {
  String language;
  bool notifications;
  bool isFirstRun;

  List clinics = [];
  List services = [];

  Future<void> setLanguage(BuildContext context, String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', languageCode);
    language = languageCode;
    MyApp.setLocale(context, Locale(languageCode));
  }

  Future<void> setNotifications(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifications', val);
    notifications = val;
    notifyListeners();
  }

  Future<void> load(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('isFirstRun')) {
      prefs.setBool('isFirstRun', false);
      isFirstRun = true;
      setNotifications(true);
      setLanguage(context, Localizations.localeOf(context).languageCode);
    } else {
      isFirstRun = false;
      language = prefs.getString('language');
      notifications = prefs.getBool('notifications');
    }
  }

  void setEntities(Entity entity, List list) {
    switch (entity) {
      case Entity.clinic:
        clinics = list;
        break;
      case Entity.service:
        services = list;
        break;
    }
    notifyListeners();
  }

  List getEntities(BuildContext context, Entity entity) {
    List list = [];
    switch (entity) {
      case Entity.clinic:
        list = json.decode(json.encode(clinics));
        break;
      case Entity.service:
        list = json.decode(json.encode(services));
        break;
    }

    final langCode = Localizations.localeOf(context).languageCode;
    if (langCode == 'en')
      list.forEach((entity) {
        entity['name'] =
            entity['name'].substring(0, entity['name'].lastIndexOf('-') - 1);
      });
    else {
      list.forEach((entity) {
        entity['name'] =
            entity['name'].substring(entity['name'].lastIndexOf('-') + 2);
      });
      list.sort((a, b) => a['name'].compareTo(b['name']));
    }
    return list;
  }

  int maxID(Entity entity) {
    switch (entity) {
      case Entity.clinic:
        return 29;
      case Entity.service:
        return 3;
      default:
        return 0;
    }
  }
}
