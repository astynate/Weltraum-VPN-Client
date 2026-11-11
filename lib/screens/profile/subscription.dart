import 'package:flutter/material.dart';
import 'package:weltraum/operators/route_operator.dart';
import 'package:weltraum/screens/subscription/PremimScreen.dart';

class PremiumCard extends StatelessWidget {
  const PremiumCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.15),
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 7),
            child: Text(
              'Premium',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 66,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 17),
      
                        Transform.rotate(
                          angle: -0.15,
                          child: const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
      
                        const SizedBox(width: 5),
      
                        const Text(
                          '128 Days',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      
                const SizedBox(width: 10),
      
                SizedBox(
                  width: 108,
                  height: 62,
                  child: ElevatedButton(
                    onPressed: () {
                      if (context.mounted) {
                        RouteOperator.push(context, PremiumScreen());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF21143F),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Top-up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      
          const SizedBox(height: 15),
      
          _Feature(
            text: 'Unlimited Connection',
            showTopBorder: true,
          ),
          _Feature(text: '1 GB/S Servers'),
          _Feature(text: '200 MB/S Servers'),
          _Feature(text: 'Russian Firewall Protocols'),
          _Feature(text: 'Game Server Finder'),
        ],
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  final String text;
  final bool showTopBorder;

  const _Feature({
    required this.text,
    this.showTopBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(
            color: Color.fromRGBO(252, 252, 252, 0.15),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 19),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromRGBO(252, 252, 252, 0.5),
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}