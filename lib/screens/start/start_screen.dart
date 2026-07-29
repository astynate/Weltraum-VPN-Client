import 'package:flutter/material.dart';
import 'package:flutter_app/classes/application/application_state.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: ApplicationState().theme.primary300Color, // ← no gradient, just a solid background
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Column(
          children: [
            SizedBox(height: 80),
            Text(
              "Weltraum VPN",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Fast. Safe. Secure.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}