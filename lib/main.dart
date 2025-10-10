import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'firebase_options.dart';
import 'landing_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
// ignore: undefined_hidden_name
import 'home_page.dart' hide RequestPage;
import 'donate_page.dart';    
import 'request_page.dart';   
import 'emergency.dart';
import 'profile_page.dart';   
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const BloodDonationApp(),
    ),
  );
}

class BloodDonationApp extends StatelessWidget {
  const BloodDonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Blood Donation App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomeScreen(),
        '/donate': (context) => const BloodDonationScreen(), 
        '/request': (context) => const BloodRequestScreen(),
        '/emergency': (context) => const EmergencyScreen(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}