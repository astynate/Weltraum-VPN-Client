import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.purpleDark, AppColors.purpleLight],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Column(
          children: [
            SizedBox(height: 80),
            Text("Weltraum VPN",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Fast. Safe. Secure.", style: TextStyle(fontSize: 18)),

            // const Spacer(),

            // const SizedBox(height: 40),

            // const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}