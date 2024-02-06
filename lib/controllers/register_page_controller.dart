import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_otp_register/controllers/login_page_controller.dart';
import 'package:supabase_otp_register/controllers/otp_verification_page_controller.dart';
import 'package:supabase_otp_register/pages/login_page.dart';
import 'package:supabase_otp_register/pages/otp_verification_page.dart';

class RegisterPageController extends GetxController {
  final Rx<bool> _isFormLoading = Rx<bool>(false);

  bool get isFormLoading => _isFormLoading.value;

  final TextEditingController fullNameInputController = TextEditingController();
  final TextEditingController emailAddressInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  final Rx<String?> _fullNameInputError = Rx<String?>(null);

  String? get fullNameInputError => _fullNameInputError.value;

  final Rx<String?> _emailAddressInputError = Rx<String?>(null);

  String? get emailAddressInputError => _emailAddressInputError.value;

  final Rx<String?> _passwordInputError = Rx<String?>(null);

  String? get passwordInputError => _passwordInputError.value;

  void onSubmitButtonPressed() async {
    bool isFormValid = validateForm();

    if (!isFormValid) {
      return;
    }

    try {
      _isFormLoading.value = true;

      final String fullName = fullNameInputController.text.trim();
      final String emailAddress = emailAddressInputController.text.trim();
      final String password = passwordInputController.text.trim();

      final AuthResponse authResponse = await Supabase.instance.client.auth.signUp(
        email: emailAddress,
        password: password,
      );

      print('authResponse geldi');
      print(authResponse.session);
      print(authResponse.user!.id);

      await Supabase.instance.client.from('user_details').insert({
        'user_id': authResponse.user!.id,
        'full_name': fullName,
      });


      Get.off(() => const OTPVerificationPage(), arguments: {'emailAddress': emailAddress});

    } on AuthException catch (authException) {
      Get.snackbar(
        authException.statusCode ?? 'Something went wrong',
        authException.message,
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 0.0,
        margin: EdgeInsets.zero,
      );
    } catch (exception) {
      print('exception geldi');
      print(exception);
    } finally {
      _isFormLoading.value = false;
      fullNameInputController.clear();
      emailAddressInputController.clear();
      passwordInputController.clear();
    }
  }

  bool validateForm() {
    _fullNameInputError.value = null;
    _emailAddressInputError.value = null;
    _passwordInputError.value = null;

    final String fullName = fullNameInputController.text.trim();
    final String emailAddress = emailAddressInputController.text.trim();
    final String password = passwordInputController.text.trim();

    bool isFullNameValid = false;
    bool isEmailAddressValid = false;
    bool isPasswordValid = false;

    if (fullName.isEmpty) {
      _fullNameInputError.value = 'This field cannot be empty';
    } else if (!fullName.replaceAll(' ', '').isAlphabetOnly) {
      _fullNameInputError.value = 'This field can include only letters';
    } else {
      isFullNameValid = true;
    }

    if (emailAddress.isEmpty) {
      _emailAddressInputError.value = 'This field cannot be empty';
    } else if (!emailAddress.isEmail) {
      _emailAddressInputError.value = 'Enter a valid e-mail address';
    } else {
      isEmailAddressValid = true;
    }

    if (password.isEmpty) {
      _passwordInputError.value = 'This field cannot be empty';
    } else {
      isPasswordValid = true;
    }

    return isFullNameValid && isEmailAddressValid && isPasswordValid;
  }

  void onLoginButtonPressed() {
    Get.off(() => const LoginPage());
  }
}
