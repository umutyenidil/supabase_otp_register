import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_otp_register/controllers/otp_verification_page_controller.dart';

class OTPVerificationPage extends StatelessWidget {
  const OTPVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    OTPVerificationPageController controller = Get.put(OTPVerificationPageController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Verify your account'),
        centerTitle: true,
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
          child: Column(
            children: [
              Obx(
                () => TextFormField(
                  controller: controller.verificationCodeInputController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Verification Code',
                    helperText: controller.verificationCodeInputError,
                    helperStyle: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: controller.onResendVerificationButtonPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 20),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: const Text('Resend verification code'),
              ),
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
                      : const Text('Verify'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
