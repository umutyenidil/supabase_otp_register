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
        title: const Text('OTP Verification Page'),
        centerTitle: true,
      ),
    );
  }
}
