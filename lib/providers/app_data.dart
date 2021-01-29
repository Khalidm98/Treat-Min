import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/enumerations.dart';
import '../main.dart';

class AppData with ChangeNotifier {
  String language;
  bool notifications;
  bool isFirstRun;

  Future setLanguage(BuildContext context, String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', languageCode);
    language = languageCode;
    MyApp.setLocale(context, Locale(languageCode));
  }

  Future setNotifications(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifications', val);
    notifications = val;
    notifyListeners();
  }

  Future load(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('isFirstRun')) {
      prefs.setBool('isFirstRun', false);
      isFirstRun = true;
      setNotifications(true);
      setLanguage(context, Localizations.localeOf(context).languageCode);
    }
    else {
      isFirstRun = false;
      language = prefs.getString('language');
      notifications = prefs.getBool('notifications');
    }
  }

  List<Map<String, String>> getBookingList(Book book) {
    switch (book) {
      case Book.clinic:
        return [
          {'name': 'Cardiology', 'icon': 'assets/icons/heart.png'},
          {'name': 'Chest and Respiratory', 'icon': 'assets/icons/lungs.png'},
          {'name': 'Dentistry', 'icon': 'assets/icons/tooth.png'},
          {'name': 'Hepatology', 'icon': 'assets/icons/liver.png'},
          {'name': 'Internal Medicine', 'icon': 'assets/icons/stomach.png'},
          {'name': 'Neurosurgery', 'icon': 'assets/icons/brain.png'},
        ];
      case Book.service:
        return [
          {'name': 'Blood Test', 'icon': 'assets/icons/blood.png'},
          {'name': 'Heart Echo', 'icon': 'assets/icons/echo.png'},
          {'name': 'X-Rays', 'icon': 'assets/icons/x-rays.png'},
        ];
      case Book.room:
        return [
          {'name': 'Delivery Room', 'icon': 'assets/icons/delivery.png'},
          {'name': 'Dialysis Unit', 'icon': 'assets/icons/dialysis.png'},
          {'name': 'Nursery', 'icon': 'assets/icons/nursery.png'},
        ];
      default:
        return [];
    }
  }
}
