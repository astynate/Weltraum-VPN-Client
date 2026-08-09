import 'package:flutter/material.dart';
import 'package:flutter_app/classes/application/application_state.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/button.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/main_button_styles/accent_button_style.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String active = "Paris";

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ApplicationState>();

    print(state.connection.status);

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: ApplicationState().theme.primary300Color,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text("Location", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Choose your desired location", style: TextStyle(fontSize: 18)),

            const SizedBox(height: 40),
            const Spacer(),

            MainButton(
              label: "Click me",
              onPressed: () {
                print("Button pressed!");
              }, 
              buttonStyle: AccentButtonStyle(),
            ),

            const SizedBox(height: 20),
            Text("Active: $active", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}