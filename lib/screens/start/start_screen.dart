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
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text("Weltraum VPN",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Fast. Safe. Secure.", style: TextStyle(fontSize: 18)),

            const Spacer(),

            const Text("Connected to Paris, France",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

            const SizedBox(height: 40),

            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text("Disconnect",
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}