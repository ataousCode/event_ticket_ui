import 'package:get/get.dart';
import '../models/auth_response_model.dart';
import '../repositories/auth_repository.dart';
import 'storage_service.dart';

class AuthService extends GetxService {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final StorageService _storageService = Get.find<StorageService>();

  final RxBool isLoggedIn = false.obs;
  final RxList<String> userRoles = <String>[].obs;

  Future<AuthService> init() async {
    final token = await _storageService.getAccessToken();
    if (token != null) {
      isLoggedIn.value = true;
      userRoles.value = await _storageService.getUserRoles();
    }
    return this;
  }

  Future<bool> login(String email, String password) async {
    final result = await _authRepository.login(email, password);

    if (result['success']) {
      final AuthResponse authResponse = result['data'];
      await _storageService.saveAccessToken(authResponse.accessToken);
      await _storageService.saveRefreshToken(authResponse.refreshToken);
      await _storageService.saveUserInfo(
        authResponse.id,
        authResponse.email,
        authResponse.roles,
      );
      isLoggedIn.value = true;
      userRoles.value = authResponse.roles;
      return true;
    }

    return false;
  }

  Future<Map<String, dynamic>> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String phoneNumber,
  ) async {
    return await _authRepository.register(
      firstName,
      lastName,
      email,
      password,
      phoneNumber,
    );
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    return await _authRepository.forgotPassword(email);
  }

  Future<Map<String, dynamic>> resetPassword(
    String token,
    String newPassword,
  ) async {
    return await _authRepository.resetPassword(token, newPassword);
  }

  Future<bool> logout() async {
    await _storageService.clearAuthData();
    isLoggedIn.value = false;
    userRoles.clear();
    return true;
  }

  bool hasRole(String role) {
    return userRoles.contains(role);
  }
}
