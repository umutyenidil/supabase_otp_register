import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_otp_register/config/supabase.dart' show url, anonKey;
import 'package:supabase_otp_register/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_otp_register/pages/otp_verification_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: url, anonKey: anonKey);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supabase OTP Register',
      home: LoginPage(),
    );
  }
}
