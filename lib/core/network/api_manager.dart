import 'package:http/http.dart' as http;

class ApiManager {
  Future<http.Response> getRequest(
      String url, {
        Map<String, String>? queryParameters,
      }) async {
    final uri = Uri.parse(url).replace(
      queryParameters: queryParameters,
    );

    return await http.get(uri);
  }
}