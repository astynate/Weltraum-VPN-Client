import 'package:flutter/material.dart';
import 'package:flutter_app/classes/application/application_state.dart';
import 'package:flutter_app/operators/google_login_operator.dart';
import 'package:flutter_app/widgets/button_content/text_button_content.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/button.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/main_button_styles/accent_button_style.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/main_button_styles/dark_button_style.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<ApplicationState>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [state.theme.backgroundGradientStart, state.theme.backgroundGradientEnd,],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios, color: Colors.white),
                  Text("Back", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 80),

            const Text(
              "Weltraum VPN",
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 0),
            const Text("Continue with:", style: TextStyle(fontSize: 24)),

            const SizedBox(height: 30),
            const Spacer(),

            MainButton(
              onPressed: () {
                final state = context.read<ApplicationState>();
                
                GoogleLoginOperator googleLoginOperator = GoogleLoginOperator(state);
                googleLoginOperator.handleGoogleLogin();
              },
              buttonStyle: AccentButtonStyle(), 
              buttonContent: TextButtonContent(
                label: "Google Account", 
                icon: 'lib/assets/icons/companies/google.svg', 
                style: AccentButtonStyle(),
              ),
            ),

            const SizedBox(height: 16),
            MainButton(
              onPressed: () {
                
              },
              buttonStyle: AccentButtonStyle(), 
              buttonContent: TextButtonContent(
                label: "Apple ID", 
                icon: Icons.apple,
                style: AccentButtonStyle(),
              ),
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "OR",
                    style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.5)),
                  ),
                ),

                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),

            const Spacer(),
            
            MainButton(
              onPressed: () {
                
              },
              buttonStyle: AccentButtonStyle(), 
              buttonContent: TextButtonContent(
                label: "Email", 
                style: AccentButtonStyle(),
              ),
            ),

            const SizedBox(height: 16),

            MainButton(
              onPressed: () {
                
              },
              buttonStyle: DarkButtonStyle(), 
              buttonContent: TextButtonContent(
                label: "Login", 
                style: DarkButtonStyle(),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}