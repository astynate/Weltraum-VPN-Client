import 'package:flutter/material.dart';
import 'package:flutter_app/classes/application/application_state.dart';
import 'package:flutter_app/elements/button_content/button_content.dart';
import 'package:flutter_app/elements/button_content/double_text_button_content.dart';
import 'package:flutter_app/elements/buttons/main_buttons/button.dart';
import 'package:flutter_app/elements/buttons/main_buttons/main_button_styles/accent_button_style.dart';
import 'package:flutter_app/elements/buttons/main_buttons/main_button_styles/button_style.dart';
import 'package:flutter_app/elements/buttons/main_buttons/main_button_styles/dark_button_style.dart';
import 'package:flutter_app/elements/buttons/main_buttons/main_button_styles/normal_button_style.dart';
import 'package:flutter_app/operators/route_operator.dart';
import 'package:flutter_app/screens/authorization/login_screen.dart';
import 'package:flutter_app/screens/home/home_screen.dart';
import 'package:flutter_app/widgets/header/header.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ApplicationState>();

  return Scaffold(
    body: SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              state.theme.backgroundGradientStart,
              state.theme.backgroundGradientEnd,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
                  child: Column(
                    children: [
                      const Header(),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 110),
                            const Text(
                              "Weltraum VPN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Fast. Safe. Secure.",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            
                            const Spacer(),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: MainButton(
                                onPressed: () => {
                                  RouteOperator.push(context, const LoginScreen())
                                }, 
                                buttonStyle: AccentButtonStyle(), 
                                buttonContent: DoubleTextButtonContent(
                                    label: 'Continue with your Account', 
                                    text: 'Create or log into your account to buy a Premium', 
                                  style: AccentButtonStyle(),
                                )
                              ),
                            ),

                            const SizedBox(height: 5),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: 
                                MainButton(
                                  onPressed: () => {
                                    RouteOperator.push(context, const HomeScreen())
                                  }, 
                                  buttonStyle: secondaryButtonStyle, 
                                  buttonContent: DoubleTextButtonContent(
                                    label: 'Continue without Login', 
                                    text: 'Start using VPN for free', 
                                    style: secondaryButtonStyle
                                  )
                              ),
                            ),

                            const SizedBox(height: 15),
                          ]
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    ),
  );
  }
}

class BottomButtonStyle extends AbstractButtonStyle {
  @override
  Color get accent => const Color.fromARGB(252, 19, 19, 229);

  @override
  Color get background => const Color.fromRGBO(255, 255, 255, 0.05);

  @override
  BorderRadius get borderRadius => const BorderRadius.all(Radius.circular(30));

  @override
  Color get foreground => const Color.fromRGBO(255, 255, 255, 1);
}

var secondaryButtonStyle = BottomButtonStyle();