// lib/app/modules/auth/views/register_view.dart
import 'package:event_ticket_ui/app/routes/app_pages.dart';
import 'package:event_ticket_ui/core/widgets/custom_button.dart';
import 'package:event_ticket_ui/core/widgets/custom_text_field.dart';
import 'package:event_ticket_ui/core/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

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
                Hero(
                  tag: 'app_logo',
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                    ),
                    child: Icon(Icons.event, size: 50, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Join Us Today',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Create an account to start booking events',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Registration form
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
                  key: controller.registerFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'First Name',
                              hint: 'Enter first name',
                              controller: controller.firstNameController,
                              validator: controller.validateName,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              label: 'Last Name',
                              hint: 'Enter last name',
                              controller: controller.lastNameController,
                              validator: controller.validateName,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Email',
                        hint: 'Enter your email',
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: controller.validateEmail,
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
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => CustomTextField(
                          label: 'Confirm Password',
                          hint: 'Confirm your password',
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
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: Colors.white70),
                          ),
                          const SizedBox(height: 8),
                          IntlPhoneField(
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            initialCountryCode: 'US',
                            dropdownTextStyle: TextStyle(color: Colors.white),
                            style: TextStyle(color: Colors.white),
                            flagsButtonPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            onChanged: (phone) {
                              controller.phoneNumber = phone.completeNumber;
                            },
                            disableLengthCheck: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Obx(
                        () => CustomButton(
                          text: 'Sign Up',
                          onPressed: controller.register,
                          isLoading: controller.isLoading.value,
                        ),
                      ),
                    ],
                  ),
                ),

                // Login link
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white70),
                    ),
                    TextButton(
                      onPressed: () => Get.offNamed(Routes.LOGIN),
                      child: Text('Sign In'),
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
