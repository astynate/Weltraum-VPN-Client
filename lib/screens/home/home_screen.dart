import 'package:flutter/material.dart';
import 'package:flutter_app/classes/application/application_state.dart';
import 'package:flutter_app/operators/route_operator.dart';
import 'package:flutter_app/screens/locations/locations_screen.dart';
import 'package:flutter_app/widgets/button_content/double_text_button_content.dart';
import 'package:flutter_app/widgets/button_content/text_button_content.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/button.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/main_button_styles/accent_button_style.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/main_button_styles/normal_button_style.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String active = "Paris";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ApplicationState>();
    // final vpnOperator = VirtualPrivateNetworkOperator(state);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7700FF),
              Color(0xFF34177D),
            ],
          ),
        ),
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
              onPressed: () {
                if (state.connection.isConnected) {
                  // vpnOperator.disconnect();
                  state.connection.changeState();
                } else {
                  // vpnOperator.connect();
                  state.connection.changeState();
                }
              },
              buttonStyle: AccentButtonStyle(), 
              buttonContent: TextButtonContent(
                label: state.connection.isConnected ? "Disconnect" : "Connect", 
                style: AccentButtonStyle(),
              ),
            ),

            const SizedBox(height: 10),

            MainButton(
              onPressed: () {
                RouteOperator.push(context, const LocationsScreen());
              },
              buttonStyle: NormalButtonStyle(), 
              buttonContent: DoubleTextButtonContent(
                label: "Lautenbourg, France", 
                text: "Active", 
                style: NormalButtonStyle(),
                icon: 'lib/assets/icons/flags/france.svg',
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}