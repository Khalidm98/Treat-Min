import 'package:http/http.dart' as http;

class ActionAPI {
  static final String _baseURL = 'https://www.treat-min.com/api';

  static Future getEntityDetail(String entity, String entityId) async {
    final response = await http.get(
      '$_baseURL/$entity/$entityId/details/',
    );
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      return "Something went wrong";
    }
  }
}
