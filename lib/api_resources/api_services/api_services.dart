import 'package:http/http.dart' as http;

class ApiServices {
  Future<http.Response> get(
    String wholeUrl,
  ) async {
    try {
      print('SERVICES :: API URL : $wholeUrl');

      http.Response response = await http.get(
        Uri.parse(wholeUrl),
      );

      print('SERVICES :: RESPONSE BODY : ${response.body}');
      print('SERVICES :: STATUS CODE : ${response.statusCode}');
      return response;
    } catch (e) {
      print('SERVICES :: ERROR : $e');
      throw Exception('Failed to make GET request: $e');
    }
  }
}
