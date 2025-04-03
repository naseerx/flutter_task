import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_response.dart';

class HandlingResponse {
  static ApiResponse returnResponse(http.Response response) {
    Map<String, dynamic>? responseData;
    try {
      responseData = jsonDecode(response.body);
    } catch (e) {
      responseData = null;
    }

    String message = responseData?['message'] ?? 'An unexpected error occurred';

    switch (response.statusCode) {
      case 200:
        return ApiResponse.completed(response.body.toString(),
            statusCode: response.statusCode);
      case 400:
      case 403:
      case 404:
        return ApiResponse.error(message, statusCode: response.statusCode);
      case 401:
        return ApiResponse.unAuthorised(message, response.statusCode);
      case 409:
        return ApiResponse.error(message, statusCode: response.statusCode);
      case 500:
        return ApiResponse.error(message, statusCode: response.statusCode);
      default:
        return ApiResponse.error(message, statusCode: response.statusCode);
    }
  }

  static ApiResponse returnException(Object exception) {
    if (exception is SocketException) {
      return ApiResponse.noInternet('No Internet');
    } else if (exception is TimeoutException) {
      return ApiResponse.timeout('Request timed out. Please try again.');
    } else {
      return ApiResponse.error('An unexpected error occurred.');
    }
  }
}
