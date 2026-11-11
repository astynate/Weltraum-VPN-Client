import 'package:flutter/material.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:weltraum/elements/button_content/double_text_button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/button.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/accent_button_style.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/button_style.dart';
import 'package:weltraum/operators/route_operator.dart';
import 'package:weltraum/screens/authorization/login_screen.dart';
import 'package:weltraum/screens/home/home_screen.dart';
import 'package:weltraum/widgets/header/header.dart';
import 'package:provider/provider.dart';

import '../../widgets/map/server_map.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  
@override
Widget build(BuildContext context) {
  final state = context.watch<ApplicationState>();

  return Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  state.theme.backgroundGradientStart,
                  state.theme.backgroundGradientEnd,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.5],
              ),
            ),
          ),
        ),

        const Positioned.fill(
          child: ServerMap(),
        ),

        SafeArea(
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: 60),
              const Center(child: Text("Weltraum VPN", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold))),
              const Center(child: Text("Fast. Safe. Secure.", style: TextStyle(fontSize: 24, color: Color.fromRGBO(255, 255, 255, 0.5)))),
              const SizedBox(height: 40),
              const Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MainButton(
                  onPressed: () {
                    RouteOperator.push(
                      context,
                      const LoginScreen(),
                    );
                  },
                  buttonStyle: AccentButtonStyle(),
                  buttonContent: DoubleTextButtonContent(
                    label: 'Continue with your Account',
                    text: 'Create or log into your account to buy a Premium',
                    style: AccentButtonStyle(),
                  ),
                ),
              ),

              const SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MainButton(
                  onPressed: () {
                    RouteOperator.push(
                      context,
                      const HomeScreen(),
                    );
                  },
                  buttonStyle: secondaryButtonStyle,
                  buttonContent: DoubleTextButtonContent(
                    label: 'Continue without Login',
                    text: 'Start using VPN for free',
                    style: secondaryButtonStyle,
                  ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ],
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