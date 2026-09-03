import 'package:flutter/material.dart';
import 'package:flutter_app/classes/application/application_state.dart';
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
          child: const SafeArea(
            child: Header(),
          ),
        ),
      ),
    );
  }
}