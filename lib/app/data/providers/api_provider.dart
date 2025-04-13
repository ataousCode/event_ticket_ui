import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../services/storage_service.dart';

class ApiProvider extends GetxService {
  //Spring Boot backend URL
  final String baseUrl = 'http://localhost:8080/api';
  final StorageService _storageService = Get.find<StorageService>();

  Future<Map<String, String>> _getHeaders({bool requiresAuth = true}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (requiresAuth) {
      final token = await _storageService.getAccessToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  Future<dynamic> get(String path, {bool requiresAuth = true}) async {
    try {
      final headers = await _getHeaders(requiresAuth: requiresAuth);
      final response = await http.get(
        Uri.parse('$baseUrl$path'),
        headers: headers,
      );
      return _processResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<dynamic> post(
    String path,
    dynamic data, {
    bool requiresAuth = true,
  }) async {
    try {
      final headers = await _getHeaders(requiresAuth: requiresAuth);
      final response = await http.post(
        Uri.parse('$baseUrl$path'),
        headers: headers,
        body: json.encode(data),
      );
      return _processResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<dynamic> put(
    String path,
    dynamic data, {
    bool requiresAuth = true,
  }) async {
    try {
      final headers = await _getHeaders(requiresAuth: requiresAuth);
      final response = await http.put(
        Uri.parse('$baseUrl$path'),
        headers: headers,
        body: json.encode(data),
      );
      return _processResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<dynamic> delete(String path, {bool requiresAuth = true}) async {
    try {
      final headers = await _getHeaders(requiresAuth: requiresAuth);
      final response = await http.delete(
        Uri.parse('$baseUrl$path'),
        headers: headers,
      );
      return _processResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);
      case 400:
        final responseBody = json.decode(response.body);
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Bad request',
        };
      case 401:
        // Handle token refresh or logout
        return {'success': false, 'message': 'Unauthorized'};
      case 403:
        return {'success': false, 'message': 'Forbidden'};
      case 404:
        return {'success': false, 'message': 'Not found'};
      case 500:
      default:
        return {'success': false, 'message': 'Server error'};
    }
  }
}
