import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_otp_register/pages/login_page.dart';
import 'package:supabase_otp_register/pages/register_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supabase OTP Register',
      home: RegisterPage(),
    );
  }
}
