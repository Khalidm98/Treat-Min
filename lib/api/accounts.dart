import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_data.dart';
import '../localizations/app_localizations.dart';

class API {
  static final String _baseURL = 'https://www.treat-min.com/api';
  static final Map<String, String> _headers = {
    "content-type": "application/json",
    "accept": "application/json"
  };

  static Future sendEmail(String email) async {
    final response = await http.post(
      '$_baseURL/accounts/send-email/',
      body: {"email": email},
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      if (jsonBody.containsKey('email')) {
        return getText('email_valid');
      } else if (jsonBody.containsKey('details')) {
        return jsonBody['details'];
      }
    }
    return 'Something went wrong!';
  }

  static Future verifyEmail(String email, int code) async {
    final response = await http.post(
      '$_baseURL/accounts/verify-email/',
      headers: _headers,
      body: json.encode({"email": email, "code": code}),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      return 'The code you entered is not correct!';
    } else if (response.statusCode == 404) {
      return 'This email address was not registered before!';
    }
    return 'Something went wrong!';
  }

  static Future register(
      BuildContext context, Map<String, String> userData) async {
    final Map<String, String> account = Map.from(userData);
    userData['birth'] = userData['birth'].substring(0, 10);
    userData.remove('photo');

    final response = await http.post(
      '$_baseURL/accounts/register/',
      body: userData,
    );

    if (response.statusCode == 201) {
      account['token'] = json.decode(response.body)['token'];
      await Provider.of<UserData>(context, listen: false).signUp(account);
      return true;
    } else if (response.statusCode == 400) {
      return json.decode(response.body)['details'];
    }
    return 'Something went wrong!';
  }
}
