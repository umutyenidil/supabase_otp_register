import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_otp_register/pages/home_page.dart';

class OTPVerificationPageController extends GetxController {
  final Rx<bool> _isFormLoading = Rx<bool>(false);

  bool get isFormLoading => _isFormLoading.value;

  final TextEditingController verificationCodeInputController = TextEditingController();

  final Rx<String?> _verificationCodeInputError = Rx<String?>(null);

  String? get verificationCodeInputError => _verificationCodeInputError.value;

  Future<void> _sendVerificationCode(String emailAddress) async {
    final ResendResponse resendResponse = await Supabase.instance.client.auth.resend(
      type: OtpType.signup,
      email: emailAddress,
    );

    print(resendResponse);
  }

  void onResendVerificationButtonPressed() async {
    try {
      Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;

      await _sendVerificationCode(arguments['emailAddress']);
    } catch (exception) {
      Get.snackbar(
        'Something went wrong',
        exception.toString(),
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 0.0,
        margin: EdgeInsets.zero,
      );
    }
  }

  void onSubmitButtonPressed() async {
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;

    final String verificationCode = verificationCodeInputController.text.trim();
    try {
      AuthResponse authResponse = await Supabase.instance.client.auth.verifyOTP(
        email: arguments['emailAddress'],
        token: verificationCode,
        type: OtpType.signup,
      );

      if (authResponse.user != null) {
        Get.off(() => const HomePage());
      } else {
        Get.snackbar(
          'Verification Failed',
          "User couldn't verify, please try again",
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 0.0,
          margin: EdgeInsets.zero,
        );
      }
    } catch (exception) {
      Get.snackbar(
        'Something went wrong',
        exception.toString(),
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 0.0,
        margin: EdgeInsets.zero,
      );
    }
    // bool isFormValid = validateForm();
    //
    // if (!isFormValid) {
    //   return;
    // }
    //
    // try {
    //   _isFormLoading.value = true;
    //
    //   final String fullName = fullNameInputController.text.trim();
    //   final String emailAddress = emailAddressInputController.text.trim();
    //   final String password = passwordInputController.text.trim();
    //
    //   final AuthResponse authResponse = await Supabase.instance.client.auth.signUp(
    //     email: emailAddress,
    //     password: password,
    //   );
    //
    //   print('authResponse geldi');
    //   print(authResponse.session);
    //   print(authResponse.user!.id);
    //
    //   await Supabase.instance.client.from('user_details').insert({
    //     'user_id': authResponse.user!.id,
    //     'full_name': fullName,
    //   });
    //
    //   final ResendResponse resendResponse = await Supabase.instance.client.auth.resend(
    //     type: OtpType.signup,
    //     email: emailAddress,
    //   );
    //
    //   print(resendResponse);
    //
    //   Get.off(() => const OTPVerificationPage());
    // } on AuthException catch (authException) {
    //   Get.snackbar(
    //     authException.statusCode ?? 'Something went wrong',
    //     authException.message,
    //     isDismissible: true,
    //     snackPosition: SnackPosition.BOTTOM,
    //     borderRadius: 0.0,
    //     margin: EdgeInsets.zero,
    //   );
    // } catch (exception) {
    //   print('exception geldi');
    //   print(exception);
    // } finally {
    //   _isFormLoading.value = false;
    //   fullNameInputController.clear();
    //   emailAddressInputController.clear();
    //   passwordInputController.clear();
    // }
  }
}
