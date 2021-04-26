import 'package:http/http.dart' as http;

class ActionAPI {
  static final String _baseURL = 'https://www.treat-min.com/api';

  static Future<String> getEntityDetail(String entity, String entityId) async {
    final response = await http.get(
      '$_baseURL/$entity/$entityId/details/',
    );
    if (response.statusCode == 200) {
      return response.body;
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
}
