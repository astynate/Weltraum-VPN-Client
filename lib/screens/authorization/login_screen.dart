import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:weltraum/elements/button_content/button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/button_style.dart';
import 'package:weltraum/elements/buttons/return_button/return_button.dart';
import 'package:weltraum/elements/button_content/text_button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/button.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/accent_button_style.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/dark_button_style.dart';
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
            // colors: [state.theme.backgroundGradientStart, state.theme.backgroundGradientEnd,],
            colors: [
              Color(0xFF64509A),
              Color(0xFF150937),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.0,
              0.5,
            ],
          ),
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 40),
            // GestureDetector(
            //   onTap: () => Navigator.pop(context),
            //   child: const Row(
            //     children: [
            //       Icon(Icons.arrow_back_ios, color: Colors.white),
            //       Text("Back", style: TextStyle(fontSize: 18)),
            //     ],
            //   ),
            // ),

        Expanded(
          child: Container(
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: Color.fromRGBO(255, 255, 255, 0.05),
            ),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                // ФОНОВАЯ КАРТА
                Positioned.fill(
                  child: IgnorePointer(
                    child: Transform.translate(
                      offset: const Offset(-100, 550),
                      child: Transform.scale(
                        scale: 7,
                        child: Image.asset(
                          'lib/assets/icons/maps/map.png',
                          opacity: const AlwaysStoppedAnimation(0.02),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReturnButton(hasText: true),
                        
                            const Spacer(),
                        
                            const Text(
                              "Weltraum VPN",
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                        
                            const Text(
                              "Continue with:",
                              style: TextStyle(
                                fontSize: 24,
                                color: Color.fromRGBO(255, 255, 255, 0.25),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // MainButton(
            //   onPressed: () {
            //     final state = context.read<ApplicationState>();
                
            //     GoogleLoginOperator googleLoginOperator = GoogleLoginOperator(state);
            //     googleLoginOperator.handleGoogleLogin();
            //   },
            //   buttonStyle: AccentButtonStyle(), 
            //   buttonContent: TextButtonContent(
            //     label: "Google Account", 
            //     icon: 'lib/assets/icons/companies/google.svg', 
            //     style: AccentButtonStyle(),
            //   ),
            // ),

            // const SizedBox(height: 16),
            // MainButton(
            //   onPressed: () {
                
            //   },
            //   buttonStyle: AccentButtonStyle(), 
            //   buttonContent: TextButtonContent(
            //     label: "Apple ID", 
            //     icon: Icons.apple,
            //     style: AccentButtonStyle(),
            //   ),
            // ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Row(
                spacing: 8.0,
                children: [
                  Expanded(
                    child: MainButton(
                      onPressed: () {
                        
                      },
                      buttonStyle: AuthorizationButtonStyle(), 
                      buttonContent: ButtonContent(
                        isCenter: true,
                        leading: SvgPicture.asset(
                          'lib/assets/icons/companies/google.svg',
                          width: 34,
                          height: 34,
                        ), 
                        style: AuthorizationButtonStyle(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MainButton(
                      onPressed: () {
                        
                      },
                      buttonStyle: AuthorizationButtonStyle(), 
                      buttonContent: ButtonContent(
                        isCenter: true,
                        leading: SvgPicture.asset(
                          'lib/assets/icons/companies/facebook.svg',
                          width: 34,
                          height: 34,
                        ), 
                        style: AuthorizationButtonStyle(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MainButton(
                      onPressed: () {
                        
                      },
                      buttonStyle: AuthorizationButtonStyle(), 
                      buttonContent: ButtonContent(
                        isCenter: true,
                        leading: SvgPicture.asset(
                          'lib/assets/icons/companies/microsoft.svg',
                          width: 34,
                          height: 34,
                        ), 
                        style: AuthorizationButtonStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(0),
                  bottomRight: .circular(0),
                ),
                color: const Color.fromRGBO(255, 255, 255, 0.05)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5.0),
                    MainButton(
                      onPressed: () {
                        
                      },
                      buttonStyle: AccentButtonStyle(), 
                      buttonContent: TextButtonContent(
                        label: "Sign in", 
                        style: AccentButtonStyle(),
                      ),
                    ),
            
                    const SizedBox(height: 8.0),
            
                    MainButton(
                      onPressed: () {
                        
                      },
                      buttonStyle: BottomButtonStyle(), 
                      buttonContent: TextButtonContent(
                        label: "Create an account", 
                        style: BottomButtonStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthorizationButtonStyle extends AbstractButtonStyle {
  @override
  Color get accent => Colors.black;

  @override
  Color get background => const Color.fromRGBO(254, 254, 254, 0.05);

  @override
  BorderRadius get borderRadius => ApplicationState().theme.borderRadius;

  @override
  Color get foreground => const Color.fromARGB(255, 255, 255, 255);
}

class BottomButtonStyle extends AbstractButtonStyle {
  @override
  Color get accent => Colors.black;

  @override
  Color get background => const Color.fromRGBO(254, 254, 254, 0.02);

  @override
  BorderRadius get borderRadius => ApplicationState().theme.borderRadius;

  @override
  Color get foreground => const Color.fromRGBO(255, 255, 255, 0.5);

  @override
  BorderSide border = const BorderSide(
    color: Color.fromRGBO(255, 255, 255, 0.15),
    width: 2,
  );
}