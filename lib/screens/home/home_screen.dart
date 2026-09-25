import 'package:flutter/material.dart';
import 'package:weltraum/assets/vpn-server/virtual_private_network_server_list.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/button_style.dart';
import 'package:weltraum/operators/route_operator.dart';
import 'package:weltraum/operators/virtual_private_network_operator.dart';
import 'package:weltraum/screens/locations/locations_screen.dart';
import 'package:weltraum/elements/button_content/double_text_button_content.dart';
import 'package:weltraum/elements/button_content/text_button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/button.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/accent_button_style.dart';
import 'package:weltraum/widgets/header/header.dart';
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

    if (state.connection.server == null) {
      state.setServer(servers.values.first);
    }

    VirtualPrivateNetworkOperator operator = VirtualPrivateNetworkOperator(state);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Color.fromARGB(255, 104, 73, 191),
              // Color.fromARGB(255, 8, 1, 29),
              state.theme.backgroundGradientStart,
              state.theme.backgroundGradientEnd,
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(height: 60),
            const Center(child: Text("Location", style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold))),
            const Center(child: Text("Choose your desired location.", style: TextStyle(fontSize: 18))),
            const SizedBox(height: 40),
            const Spacer(),

            MainButton(
              onPressed: () {
                if (state.connection.isConnected) {
                  operator.disconnect();
                } else {
                  operator.connect();
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
              buttonStyle: BottomButtonStyle(), 
              buttonContent: DoubleTextButtonContent(
                label: "${state.connection.server!.city}, ${state.connection.server!.country}", 
                text: state.connection.isConnected ? "Active" : "Passive", 
                style: BottomButtonStyle(),
                icon: state.connection.server!.flag,
              ),
            ),
            
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class BottomButtonStyle extends AbstractButtonStyle {
  @override
  Color get background => const Color.fromRGBO(255, 255, 255, 0.15);

  @override
  BorderRadius get borderRadius => ApplicationState().theme.borderRadius;

  @override
  Color get foreground => const Color.fromRGBO(255, 255, 255, 1);
  
  @override
  Color get accent => const Color.fromARGB(255, 104, 73, 191);
}