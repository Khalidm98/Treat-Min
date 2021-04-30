import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_data.dart';
import 'dart:convert';

class ActionAPI {
  static final String _baseURL = 'https://www.treat-min.com/api';

  static Future<String> getEntityDetail(String entity, String entityId) async {
    final response = await http.get(
      '$_baseURL/$entity/$entityId/details/',
    );
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    }
    return "Something went wrong";
  }

  static Future<String> getEntitySchedule(
      String entity, String entityId, String entityDetailId) async {
    final response = await http.get(
      '$_baseURL/$entity/$entityId/details/$entityDetailId/schedules/',
    );
    if (response.statusCode == 200) {
      return response.body;
    }
    return "Something went wrong";
  }

  static Future<String> getEntityReviews(
      String entity, String entityId, String entityDetailId) async {
    final response = await http.get(
      '$_baseURL/$entity/$entityId/details/$entityDetailId/reviews/',
    );
    if (response.statusCode == 200) {
      return response.body;
    }
    return "Something went wrong";
  }

  static Future reserveAppointment(
      BuildContext context,
      String entity,
      String entityId,
      String entityDetailId,
      String scheduleId,
      String appointmentDate) async {
    final token = Provider.of<UserData>(context, listen: false).token;
    final response = await http.post(
      '$_baseURL/$entity/$entityId/details/$entityDetailId/reserve/',
      headers: {
        "Authorization": "Token $token",
        "content-type": "application/json",
        "accept": "application/json"
      },
      body: json.encode(
          {"schedule": scheduleId, "appointment_date": appointmentDate}),
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (response.statusCode == 401) {
      return "Invalid Token";
    }
    return jsonResponse["details"];
  }

  static Future getUserAppointments(BuildContext context) async {
    final token = Provider.of<UserData>(context, listen: false).token;
    final response = await http.get(
      '$_baseURL/user/appointments/',
      headers: {
        "Authorization": "Token $token",
        "content-type": "application/json",
        "accept": "application/json"
      },
    );

    if (response.statusCode == 401) {
      return "Invalid Token";
    }
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    }
    return "Something went wrong";
  }

  static Future cancelAppointment(
      BuildContext context, String entity, int appointmentId) async {
    final token = Provider.of<UserData>(context, listen: false).token;
    final response = await http.delete(
      '$_baseURL/user/appointments/$entity/$appointmentId/cancel/',
      headers: {
        "Authorization": "Token $token",
        "content-type": "application/json",
        "accept": "application/json"
      },
    );

    if (response.statusCode == 401) {
      return "Invalid Token";
    }
    if (response.statusCode == 200) {
      return response.body;
    }
    return "Something went wrong";
  }

  static Future rateAppointment(
      BuildContext context,
      String entity,
      String entityId,
      String entityDetailId,
      String rating,
      String review) async {
    final token = Provider.of<UserData>(context, listen: false).token;
    final response = await http.post(
        '$_baseURL/$entity/$entityId/details/$entityDetailId/rate/',
        headers: {
          "Authorization": "Token $token",
          "content-type": "application/json",
          "accept": "application/json"
        },
        body: json.encode({"rating": rating, "review": review}));
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (response.statusCode == 401) {
      return "Invalid Token";
    }
    return jsonResponse["details"];
  }
}
