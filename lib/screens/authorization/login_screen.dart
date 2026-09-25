import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:weltraum/elements/button_content/button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/button_style.dart';
import 'package:weltraum/elements/buttons/return_button/return_button.dart';
import 'package:weltraum/elements/button_content/text_button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/button.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/accent_button_style.dart';
import 'package:provider/provider.dart';
import 'package:weltraum/operators/facebook_login_operator.dart';
import 'package:weltraum/operators/google_login_operator.dart';
import 'package:weltraum/operators/microsoft_login_operator.dart';
import 'package:weltraum/operators/twitter_login_operator.dart';

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
            colors: [Color(0xFF64509A), Color(0xFF150937)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5],
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
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 0.00),
                ),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
                            child: ReturnButton(hasText: true),
                          ),

                          const Spacer(),

                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                              child: Container(
                                color: const Color.fromRGBO(0, 0, 0, 0.07),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 21.0,
                                    vertical: 24.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                          color: Color.fromRGBO(
                                            255,
                                            255,
                                            255,
                                            0.25,
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 25),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0,
                                        ),
                                        child: Row(
                                          spacing: 12.0,
                                          children: [
                                            Expanded(
                                              child: MainButton(
                                                onPressed: () async {
                                                  final state = context.read<ApplicationState>();

                                                  GoogleLoginOperator googleLoginOperator = GoogleLoginOperator(state);
                                                  print(googleLoginOperator);
                                                  var result = await googleLoginOperator.handleGoogleLogin();
                                                  print(result);
                                                },
                                                buttonStyle:
                                                    AuthorizationButtonStyle(),
                                                buttonContent: ButtonContent(
                                                  isCenter: true,
                                                  leading: SvgPicture.asset(
                                                    'lib/assets/icons/companies/google.svg',
                                                    width: 34,
                                                    height: 34,
                                                  ),
                                                  style:
                                                      AuthorizationButtonStyle(),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: MainButton(
                                                onPressed: () {
                                                  FacebookLoginOperator.login();
                                                },
                                                buttonStyle:
                                                    AuthorizationButtonStyle(),
                                                buttonContent: ButtonContent(
                                                  isCenter: true,
                                                  leading: SvgPicture.asset(
                                                    'lib/assets/icons/companies/facebook.svg',
                                                    width: 34,
                                                    height: 34,
                                                  ),
                                                  style:
                                                      AuthorizationButtonStyle(),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: MainButton(
                                                onPressed: () async {
                                                  final code = await MicrosoftLoginOperator.login();

                                                  
                                                },
                                                buttonStyle:
                                                    AuthorizationButtonStyle(),
                                                buttonContent: ButtonContent(
                                                  isCenter: true,
                                                  leading: SvgPicture.asset(
                                                    'lib/assets/icons/companies/microsoft.svg',
                                                    width: 34,
                                                    height: 34,
                                                  ),
                                                  style:
                                                    AuthorizationButtonStyle(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 20),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 1,
                                              color: const Color.fromRGBO(
                                                255,
                                                255,
                                                255,
                                                0.25,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 32,
                                            ),
                                            child: Text(
                                              'OR',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                  255,
                                                  255,
                                                  255,
                                                  0.35,
                                                ),
                                                fontSize: 21,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 1,
                                              color: const Color.fromRGBO(
                                                255,
                                                255,
                                                255,
                                                0.25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 20),

                                      MainButton(
                                        onPressed: () {},
                                        buttonStyle: AccentButtonStyle(),
                                        buttonContent: TextButtonContent(
                                          label: "Sign in",
                                          style: AccentButtonStyle(),
                                        ),
                                      ),

                                      const SizedBox(height: 8.0),

                                      MainButton(
                                        onPressed: () {},
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
                            ),
                          ),
                        ],
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
            // const SizedBox(height: 16),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 60.0),
            //   child: Row(
            //     spacing: 8.0,
            //     children: [
            //       Expanded(
            //         child: MainButton(
            //           onPressed: () {

            //           },
            //           buttonStyle: AuthorizationButtonStyle(),
            //           buttonContent: ButtonContent(
            //             isCenter: true,
            //             leading: SvgPicture.asset(
            //               'lib/assets/icons/companies/google.svg',
            //               width: 34,
            //               height: 34,
            //             ),
            //             style: AuthorizationButtonStyle(),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: MainButton(
            //           onPressed: () {

            //           },
            //           buttonStyle: AuthorizationButtonStyle(),
            //           buttonContent: ButtonContent(
            //             isCenter: true,
            //             leading: SvgPicture.asset(
            //               'lib/assets/icons/companies/facebook.svg',
            //               width: 34,
            //               height: 34,
            //             ),
            //             style: AuthorizationButtonStyle(),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: MainButton(
            //           onPressed: () {

            //           },
            //           buttonStyle: AuthorizationButtonStyle(),
            //           buttonContent: ButtonContent(
            //             isCenter: true,
            //             leading: SvgPicture.asset(
            //               'lib/assets/icons/companies/microsoft.svg',
            //               width: 34,
            //               height: 34,
            //             ),
            //             style: AuthorizationButtonStyle(),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 2),

            // Container(
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(50),
            //       topRight: Radius.circular(50),
            //       bottomLeft: Radius.circular(0),
            //       bottomRight: .circular(0),
            //     ),
            //     color: const Color.fromRGBO(255, 255, 255, 0.05)
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 24.0,
            //       vertical: 20.0
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const SizedBox(height: 5.0),
            //         MainButton(
            //           onPressed: () {

            //           },
            //           buttonStyle: AccentButtonStyle(),
            //           buttonContent: TextButtonContent(
            //             label: "Sign in",
            //             style: AccentButtonStyle(),
            //           ),
            //         ),

            //         const SizedBox(height: 8.0),

            //         MainButton(
            //           onPressed: () {

            //           },
            //           buttonStyle: BottomButtonStyle(),
            //           buttonContent: TextButtonContent(
            //             label: "Create an account",
            //             style: BottomButtonStyle(),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
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
