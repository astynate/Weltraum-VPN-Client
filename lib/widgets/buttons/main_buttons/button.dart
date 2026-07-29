import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/main_button_styles/button_style.dart';

class MainButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final AbstractButtonStyle buttonStyle;

  const MainButton({
    super.key,
    required this.label,
    required this.onPressed, 
    required this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: buttonStyle.background,
          borderRadius: buttonStyle.borderRadius,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: buttonStyle.foreground,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}