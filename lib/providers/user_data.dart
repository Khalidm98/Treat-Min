import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData with ChangeNotifier {
  // replace id with token
  String id;
  String name;
  String phone;
  String photo;
  DateTime birth;
  bool isLoggedIn = false;

  Future<void> tryAutoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return;
    }
    final userData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    id = userData['id'];
    name = userData['name'];
    phone = userData['phone'];
    photo = userData['photo'];
    birth = DateTime.parse(userData['birth']);
    isLoggedIn = true;
  }

  Future<void> signUp(Map<String, String> data) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'id': data['id'],
      'name': data['name'],
      'phone': data['phone'],
      'photo': data['photo'],
      'birth': data['birth'],
    });
    if (prefs.containsKey('userData')) {
      prefs.remove('userData');
    }
    prefs.setString('userData', userData);
    tryAutoLogIn();
    notifyListeners();
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    isLoggedIn = false;
  }
}
