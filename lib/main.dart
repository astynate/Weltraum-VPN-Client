import 'package:flutter/material.dart';
import 'package:flutter_app/operators/jason_web_token_operator.dart';
import 'screens/home/home_screen.dart';
import 'classes/application/application_state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final state = ApplicationState();
  final jwtOperator = JasonWebTokenOperator();
  final bool loggedIn = await jwtOperator.setUpUser(state);

  // runApp(
  //   WeltraumVPN(
  //     appState: appState,
  //     initialRoute: loggedIn ? "/home" : "/",
  //   ),
  // );
runApp(
  ChangeNotifierProvider<ApplicationState>.value(
      value: state,
      child: WeltraumVPN(
        appState: state,
        initialRoute: '/home',
      ),
    ),
  );
}

class WeltraumVPN extends StatelessWidget {
  final ApplicationState appState;
  final String initialRoute;

  const WeltraumVPN({
    super.key,
    required this.appState,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weltraum VPN",
      theme: ThemeData(
        fontFamily: "Inter",
        brightness: Brightness.dark,
      ),
      initialRoute: initialRoute,
      routes: {
        // "/": (context) => const StartScreen(),
        "/home": (context) => const HomeScreen(),
      },
    );
  }
}