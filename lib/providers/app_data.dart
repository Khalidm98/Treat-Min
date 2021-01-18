import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/enumerations.dart';

class AppData with ChangeNotifier {
  Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('OpenedBefore')) {
      prefs.setBool('OpenedBefore', true);
      return true;
    }
    return false;
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
