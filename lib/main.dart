import 'package:flutter/material.dart';
import 'screens/authorization/login_screen.dart';
import 'screens/location_screen.dart';
import 'screens/start/start_screen.dart';

void main() {
  runApp(const WeltraumVPN());
}

class WeltraumVPN extends StatelessWidget {
  const WeltraumVPN({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weltraum VPN",
      theme: ThemeData(
        fontFamily: "Inter",
        brightness: Brightness.dark,
      ),
      routes: {
        "/": (context) => const LoginScreen(),
        "/location": (context) => const LocationScreen(),
        "/home": (context) => const StartScreen(),
      },
    );
  }
}