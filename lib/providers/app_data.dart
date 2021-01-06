import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData with ChangeNotifier {
  Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('OpenedBefore')) {
      prefs.setBool('OpenedBefore', true);
      return true;
    }
    return false;
  }
}
