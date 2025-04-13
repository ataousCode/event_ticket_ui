import 'package:event_ticket_ui/core/widgets/custom_button.dart';
import 'package:event_ticket_ui/core/widgets/custom_text_field.dart';
import 'package:event_ticket_ui/core/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ResetPasswordView extends GetView<AuthController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the token from the route parameters if available
    final token = Get.parameters['token'];
    if (token != null && token.isNotEmpty) {
      controller.tokenController.text = token;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Reset Password'), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.lock_open,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Set New Password',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Create a new password for your account.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Reset password form
                Obx(
                  () =>
                      controller.errorMessage.isNotEmpty
                          ? Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ErrorMessage(
                              message: controller.errorMessage.value,
                            ),
                          )
                          : const SizedBox.shrink(),
                ),
                Form(
                  key: controller.resetPasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        label: 'Reset Token',
                        hint: 'Enter the token from email',
                        controller: controller.tokenController,
                        validator: controller.validateToken,
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => CustomTextField(
                          label: 'New Password',
                          hint: 'Enter your new password',
                          controller: controller.passwordController,
                          obscureText: controller.obscurePassword.value,
                          validator: controller.validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscurePassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.white70,
                            ),
                            onPressed: controller.toggleObscurePassword,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => CustomTextField(
                          label: 'Confirm New Password',
                          hint: 'Confirm your new password',
                          controller: controller.confirmPasswordController,
                          obscureText: controller.obscureConfirmPassword.value,
                          validator: controller.validateConfirmPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscureConfirmPassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.white70,
                            ),
                            onPressed: controller.toggleObscureConfirmPassword,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Obx(
                      //   () => CustomButton(
                      //     text: 'Reset Password',
                      //     onPressed: controller.resetPassword,
                      //     isLoading: controller.isLoading.value,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
