import 'package:event_ticket_ui/app/routes/app_pages.dart';
import 'package:event_ticket_ui/core/widgets/custom_button.dart';
import 'package:event_ticket_ui/core/widgets/custom_text_field.dart';
import 'package:event_ticket_ui/core/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo and title
                Hero(
                  tag: 'app_logo',
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                    ),
                    child: Icon(Icons.event, size: 60, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Good to see you back!',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Login form
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
                  key: controller.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        label: 'Email',
                        hint: 'Enter your email',
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: controller.validateEmail,
                        onSubmitted: (_) => controller.login(),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => CustomTextField(
                          label: 'Password',
                          hint: 'Enter your password',
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
                          onSubmitted: (_) => controller.login(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                          child: Text('Forgot Password?'),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Obx(
                        () => CustomButton(
                          text: 'Sign In',
                          onPressed: controller.login,
                          isLoading: controller.isLoading.value,
                        ),
                      ),
                    ],
                  ),
                ),

                // Registration link
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white70),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.REGISTER),
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
