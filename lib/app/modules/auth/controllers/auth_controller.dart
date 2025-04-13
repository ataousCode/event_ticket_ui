// lib/app/modules/auth/controllers/auth_controller.dart
import 'package:event_ticket_ui/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();

  // Add this new property to store the formatted phone number
  String phoneNumber = '';

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    tokenController.dispose();
    super.onClose();
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleObscureConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(value)) {
      return 'Password must contain uppercase, lowercase, number, and special character';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // Phone validation is handled by the IntlPhoneField widget
    return null;
  }

  String? validateToken(String? value) {
    if (value == null || value.isEmpty) {
      return 'Token is required';
    }
    return null;
  }

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final success = await _authService.login(
        emailController.text.trim(),
        passwordController.text,
      );

      if (success) {
        Get.offAllNamed(Routes.HOME);
      } else {
        errorMessage.value = 'Invalid email or password';
      }
    } catch (e) {
      errorMessage.value = 'Failed to login: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _authService.register(
        firstNameController.text.trim(),
        lastNameController.text.trim(),
        emailController.text.trim(),
        passwordController.text,
        phoneNumber.trim(),
      );

      if (result['success']) {
        Get.snackbar(
          'Success',
          'Registration successful. Please login.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(8),
        );
        Get.offAllNamed(Routes.LOGIN);
      } else {
        errorMessage.value = result['message'] ?? 'Registration failed';
      }
    } catch (e) {
      errorMessage.value = 'Failed to register: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    if (!forgotPasswordFormKey.currentState!.validate()) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _authService.forgotPassword(
        emailController.text.trim(),
      );

      if (result['success']) {
        Get.snackbar(
          'Success',
          'Password reset instructions sent to your email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(8),
        );
        // In a real app, direct to login or confirmation page
        Get.offAllNamed(Routes.LOGIN);
      } else {
        errorMessage.value = result['message'] ?? 'Failed to process request';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> resetPassword() async {
  //   if (!resetPasswordFormKey.currentState!.validate()) return;

  //   isLoading.value = true;
  //   errorMessage.value = '';

  //   try {
  //     final result = await _authService.resetPassword(
  //       tokenController.text.trim(),
  //       passwordController.text,
  //     );

  //     if (result['success']) {
  //       Get.snackbar(
  //         'Success',
  //         'Password reset successful. Please login with your new password.',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //         margin: const EdgeInsets.all(8),
  //         duration: const Duration(seconds: 5),
  //       );
  //       Get.offAllNamed(Routes.LOGIN);
  //     } else {
  //       errorMessage.value = result['message'] ?? 'Failed to reset password';
  //     }
  //   } catch (e) {
  //     errorMessage.value = 'Error: ${e.toString()}';
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void logout() {
    _authService.logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}
