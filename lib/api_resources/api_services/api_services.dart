import 'package:http/http.dart' as http;

class ApiServices {
  Future<http.Response> postJson(
    String wholeUrl,
    Map<String, dynamic> body,
  ) async {
    try {
      print('SERVICES :: API URL : $wholeUrl');
      print('SERVICES :: API BODY : $body');

      final response = await http.post(
        Uri.parse(wholeUrl),
        body: body,
      );

      print('SERVICES :: RESPONSE BODY : ${response.body}');
      print('SERVICES :: STATUS CODE : ${response.statusCode}');
      return response;
    } catch (error) {
      print('Error occurred: $error');
      throw Exception('Failed to post API: $error');
    }
  }

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
