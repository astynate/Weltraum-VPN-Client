import 'package:flutter/material.dart';
import 'package:flutter_app/operators/jason_web_token_operator.dart';
import 'package:flutter_app/screens/authorization/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'classes/application/application_state.dart';
import 'package:provider/provider.dart';

// TO USE STATE
// final state = context.read<ApplicationState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final state = ApplicationState();
  final jwtOperator = JasonWebTokenOperator();
  final bool loggedIn = await jwtOperator.setUpUser(state);

  print(state.account);
  print(state.accessToken);
  print(state.refreshToken);

  runApp(
    ChangeNotifierProvider<ApplicationState>.value(
        value: state,
        child: WeltraumVPN(
          state: state,
          initialRoute: '/login',
        ),
      ),
    );
}

class WeltraumVPN extends StatelessWidget {
  final ApplicationState state;
  final String initialRoute;

  const WeltraumVPN({
    super.key,
    required this.state,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weltraum VPN",
      theme: ThemeData(
        fontFamily: "Lato",
        brightness: Brightness.dark,
      ),
      initialRoute: initialRoute,
      routes: {
        // "/": (context) => const StartScreen(),
        "/home": (context) => const HomeScreen(),
        "/login": (context) => const LoginScreen(),
      },
    );
  }
}