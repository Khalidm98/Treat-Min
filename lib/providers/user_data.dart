import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData with ChangeNotifier {
  String token;
  String name;
  String email;
  String gender;
  String phone;
  String photo;
  DateTime birth;
  bool isLoggedIn = false;

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return;
    }
    final userData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    token = userData['token'];
    name = userData['name'];
    email = userData['email'];
    gender = userData['gender'];
    phone = userData['phone'];
    photo = userData['photo'];
    birth = DateTime.parse(userData['birth']);
    isLoggedIn = true;
  }

  Future<void> saveData(Map<String, String> data) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(data);
    if (prefs.containsKey('userData')) {
      prefs.remove('userData');
    }
    prefs.setString('userData', userData);
    tryAutoLogin();
    notifyListeners();
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    isLoggedIn = false;
  }
}
