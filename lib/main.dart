
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:weltraum/classes/application/application_state.dart';
import 'package:weltraum/classes/application/premium_state.dart';
import 'package:weltraum/screens/authorization/login_screen.dart';
import 'package:weltraum/screens/start/start_screen.dart';
import 'screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = const String.fromEnvironment(
    'STRIPE_PUBLISHABLE_KEY',
  );

  try {
    if (Stripe.publishableKey.isNotEmpty) {
      await Stripe.instance.applySettings();
    } else {
      debugPrint('Stripe publishable key is not configured.');
    }
  } catch (e, stackTrace) {
    debugPrint('Stripe initialization error: $e');
    debugPrintStack(stackTrace: stackTrace);
  }

  final applicationState = ApplicationState();
  final premiumState = PremiumState();

  try {
    await premiumState.loadSubscription();
  } catch (e, stackTrace) {
    debugPrint('Failed to load subscription: $e');
    debugPrintStack(stackTrace: stackTrace);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ApplicationState>.value(
          value: applicationState,
        ),
        ChangeNotifierProvider<PremiumState>.value(
          value: premiumState,
        ),
      ],
      child: const WeltraumVPN(),
    ),
  );
}

class WeltraumVPN extends StatelessWidget {
  const WeltraumVPN({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weltraum VPN',
      theme: ThemeData(
        fontFamily: 'Lato',
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const StartScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}