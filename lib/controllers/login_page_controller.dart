import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  final Rx<bool> _isFormLoading = Rx<bool>(false);

  bool get isFormLoading => _isFormLoading.value;

  final TextEditingController emailAddressInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

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
      await Future.delayed(const Duration(milliseconds: 1250));
    } catch (exception) {
      print('exception');
    } finally {
      _isFormLoading.value = false;
      emailAddressInputController.clear();
      passwordInputController.clear();
    }
  }

  bool validateForm() {
    _emailAddressInputError.value = null;
    _passwordInputError.value = null;

    final String emailAddress = emailAddressInputController.text;
    bool isEmailAddressValid = false;
    final String password = passwordInputController.text;
    bool isPasswordValid = false;

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

    return isEmailAddressValid && isPasswordValid;
  }
}
