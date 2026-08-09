import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios, color: Colors.white),
                  Text("Back", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 40),

            const Text(
              "Weltraum VPN",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),
            const Text("Continue with:", style: TextStyle(fontSize: 18)),

            const SizedBox(height: 30),

            _loginButton(
              icon: Icons.g_mobiledata,
              text: "Google Account",
              onTap: () {
                Navigator.pushNamed(context, "/location");
              },
            ),

            const SizedBox(height: 16),

            _loginButton(
              icon: Icons.apple,
              text: "Apple ID",
              onTap: () {
                Navigator.pushNamed(context, "/location");
              },
            ),

            const SizedBox(height: 30),
            const Center(child: Text("OR", style: TextStyle(fontSize: 16))),

            const SizedBox(height: 20),

            _simpleButton("Email", () {
              Navigator.pushNamed(context, "/location");
            }),

            const SizedBox(height: 16),

            _simpleButton("Login", () {
              Navigator.pushNamed(context, "/location");
            }),
          ],
        ),
      ),
    );
  }

  Widget _loginButton({required IconData icon, required String text, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 24, 246, 246),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black, size: 28),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(color: Colors.black, fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _simpleButton(String text, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(text, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}