import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_otp_register/controllers/login_page_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginPageController controller = Get.put(LoginPageController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
              child: Form(
                child: Column(
                  children: [
                    Obx(
                      () => TextFormField(
                        controller: controller.emailAddressInputController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Your e-mail address',
                          helperText: controller.emailAddressInputError,
                          helperStyle: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Obx(
                      () => TextFormField(
                        controller: controller.passwordInputController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Your password',
                          helperText: controller.passwordInputError,
                          helperStyle: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Obx(
                      () => ElevatedButton(
                        onPressed: (controller.isFormLoading) ? null : controller.onSubmitButtonPressed,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 20),
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        child: (controller.isFormLoading)
                            ? const SizedBox.square(
                                dimension: 20.0,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Login'),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: controller.onRegisterButtonPressed,
                      child: const Text('register'),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
