// lib/app/data/repositories/auth_repository.dart
import 'package:get/get.dart';
import '../models/auth_response_model.dart';
import '../providers/api_provider.dart';

class AuthRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _apiProvider.post(
      '/auth/login',
      {'email': email, 'password': password},
      requiresAuth: false,
    );

    if (response['success'] == false) {
      return response;
    }

    try {
      final authResponse = AuthResponse.fromJson(response);
      return {
        'success': true,
        'data': authResponse,
      };
    } catch (e) {
      return {'success': false, 'message': 'Failed to parse response'};
    }
  }

  Future<Map<String, dynamic>> register(String firstName, String lastName, String email, 
      String password, String phoneNumber) async {
    final response = await _apiProvider.post(
      '/auth/register',
      {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
      },
      requiresAuth: false,
    );

    return response;
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await _apiProvider.post(
      '/auth/forgot-password',
      {'email': email},
      requiresAuth: false,
    );

    return response;
  }

  Future<Map<String, dynamic>> resetPassword(String token, String newPassword) async {
    final response = await _apiProvider.post(
      '/auth/reset-password',
      {'token': token, 'password': newPassword},
      requiresAuth: false,
    );

    return response;
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final response = await _apiProvider.post(
      '/auth/refresh',
      {'refreshToken': refreshToken},
      requiresAuth: false,
    );

    if (response['success'] == false) {
      return response;
    }

    try {
      final authResponse = AuthResponse.fromJson(response);
      return {
        'success': true,
        'data': authResponse,
      };
    } catch (e) {
      return {'success': false, 'message': 'Failed to parse response'};
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    final response = await _apiProvider.get('/users/me');
    return response;
  }
}