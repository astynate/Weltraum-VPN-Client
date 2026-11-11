import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:weltraum/elements/button_content/row_icon_text_button_content.dart';
import 'package:weltraum/elements/button_content/text_button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/button.dart';
import 'package:weltraum/elements/buttons/return_button/return_button.dart';
import 'package:weltraum/screens/authorization/login_screen.dart';
import 'package:weltraum/screens/profile/avatar.dart';
import 'package:weltraum/screens/profile/subscription.dart';
import 'package:weltraum/screens/profile/subscriptions.dart';
import 'package:weltraum/widgets/menu_button/menu_button.dart';
import 'package:weltraum/widgets/menu_button/menu_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final HeaderMenuController menuController;

  @override
  void initState() {
    super.initState();

    menuController = HeaderMenuController(this);
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ApplicationState>();
    final account = state.account;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              state.theme.backgroundGradientStart,
              state.theme.backgroundGradientEnd,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [
              0.0,
              0.5,
            ],
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 90.0,
                  bottom: 30.0,
                ),
                child: Column(
                  children: [
                    Avatar(
                      state: state,
                    ),

                    const SizedBox(
                      height: 8.0,
                    ),

                    if (account != null)
                      Text(
                        account.fullName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                    if (account != null)
                      const SizedBox(
                        height: 4.0,
                      ),

                    if (account != null)
                      Text(
                        account.email,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color.fromARGB(
                            88,
                            255,
                            255,
                            255,
                          ),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    const SizedBox(
                      height: 24.0,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: MainButton(
                            onPressed: () async {

                            },
                            buttonStyle: AuthorizationButtonStyle(),
                            buttonContent: RowIconTextButtonContent(
                              label: 'Edit',
                              style: AuthorizationButtonStyle(),
                              icon: Icons.edit,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 10.0,
                        ),

                        Expanded(
                          child: MainButton(
                            onPressed: () async {

                            },
                            buttonStyle: AuthorizationButtonStyle(),
                            buttonContent: RowIconTextButtonContent(
                              label: 'Switch',
                              style: AuthorizationButtonStyle(),
                              icon: Icons.switch_account_sharp,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 10.0,
                        ),

                        Expanded(
                          child: MainButton(
                            onPressed: () async {

                            },
                            buttonStyle: AuthorizationButtonStyle(),
                            buttonContent: RowIconTextButtonContent(
                              label: 'Logout',
                              style: AuthorizationButtonStyle(),
                              icon: Icons.logout,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 16.0,
                    ),

                    MainButton(
                      onPressed: () async {

                      },
                      buttonStyle: AuthorizationButtonStyle(),
                      buttonContent: TextButtonContent(
                        label: 'Settings',
                        style: AuthorizationButtonStyle(),
                        icon: Icons.settings,
                        isCenter: false,
                      ),
                    ),

                    const SizedBox(
                      height: 16.0,
                    ),

                    if (account != null)
                      PremiumCard(),

                    const SizedBox(
                      height: 20.0,
                    ),

                    Subscriptions(),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 25.0,
                    sigmaY: 25.0,
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Row(
                        children: [
                          const ReturnButton(),
                          const Spacer(),
                          HeaderMenuButton(
                            controller: menuController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}