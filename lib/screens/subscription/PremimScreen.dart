import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:weltraum/classes/application/premium_state.dart';
import 'package:weltraum/elements/button_content/text_button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/button.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/accent_button_style.dart';
import 'package:weltraum/operators/route_operator.dart';
import 'package:weltraum/screens/start/start_screen.dart';
import 'package:weltraum/screens/subscription/PaymentScreen.dart';
import 'package:weltraum/widgets/header/header.dart';

class PremiumScreen extends StatefulWidget {
  bool firstTime = false;

  PremiumScreen({super.key, this.firstTime = false});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ApplicationState>();
    final premiumState = context.watch<PremiumState>();

    if (widget.firstTime == false) {
        widget.firstTime = true; 
    }
    
    // premiumState.clear();
    // premiumState.setSubscription(SubscriptionType.premium, duration: 3);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              state.theme.backgroundGradientStart,
              state.theme.backgroundGradientEnd,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.0,
              0.5,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 0,
            ),
            child: Column(
              children: [
                Header(text: "Premium", isHasIcon: false, isHasPaddings: false,),
                
                const SizedBox(height: 40),

                const Text(
                  'Plan & Subscription',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 38,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 3),

                const Text(
                  'Choose your plan or subscription.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mutedColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 30),
                
                // const Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'Choose Your Plan',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 20,
                //       fontWeight: FontWeight.w700,
                //     ),
                //   ),
                // ),

                Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .07),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Premium',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 28,
                        color: Colors.white24,
                      ),
                      const SizedBox(width: 14),
                      Text(
                        premiumState.duration == 0
                            ? '${premiumState.currency.symbol}${premiumState.monthlyPrice} / Month'
                            : '${premiumState.currency.symbol}${(premiumState.monthlyPrice * premiumState.duration).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // const Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'Duration',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 20,
                //       fontWeight: FontWeight.w700,
                //     ),
                //   ),
                // ),

                const SizedBox(height: 5),

                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 15,
                      sigmaY: 15,
                    ),
                    child: Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(20),
                        // border: Border.all(
                        //   color: Colors.white.withValues(alpha: 0.12),
                        // ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: premiumState.duration,
                                isExpanded: true,
                                dropdownColor: const Color.fromARGB(255, 17, 5, 54),
                                borderRadius: BorderRadius.circular(20),
                                iconEnabledColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text('1 Month'),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text('2 Months'),
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text('3 Months'),
                                  ),
                                  DropdownMenuItem(
                                    value: 6,
                                    child: Text('6 Months'),
                                  ),
                                  DropdownMenuItem(
                                    value: 12,
                                    child: Text('1 Year'),
                                  ),
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text('Monthly Subscription'),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    premiumState.setSubscription(
                                      SubscriptionType.premium,
                                      duration: value,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Spacer(),

                MainButton(
                  onPressed: () {
                    RouteOperator.push(context, PaymentScreen());
                  },
                  buttonStyle: AccentButtonStyle(),
                  buttonContent: TextButtonContent(
                    label: "Next",
                    style: AccentButtonStyle(),
                  ),
                ),

                const SizedBox(height: 8.0),

                MainButton(
                    onPressed: () => {
                      Navigator.pop(context)
                      // RouteOperator.push(context, const HomeScreen())
                    }, 
                    buttonStyle: secondaryButtonStyle, 
                    buttonContent: TextButtonContent(
                      label: "Back",
                      style: secondaryButtonStyle,
                    ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField({required String hint}) {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: .35),
            fontWeight: FontWeight.w600,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
        ),
      ),
    );
  }

  Future<Object?> createPaymentIntent(int i) async {
    // final response = await http.post(
    //     Uri.parse(
    //     'https://your-server.com/create-payment-intent',
    //     ),
    //     headers: {
    //     'Content-Type': 'application/json',
    //     },
    //     body: jsonEncode({
    //     'amount': 1,
    //     }),
    //     );
    //      
    //     final data = jsonDecode(response.body);
    //      
    //     return data['clientSecret'];

    return null;
  }
}