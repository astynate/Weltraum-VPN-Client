import 'package:flutter/material.dart';
import 'package:flutter_app/elements/button_content/button_content.dart';
import 'package:flutter_app/elements/buttons/main_buttons/main_button_styles/button_style.dart';

class MainButton extends StatefulWidget {
  final VoidCallback onPressed;
  final AbstractButtonStyle buttonStyle;
  final ButtonContent buttonContent;

  const MainButton({
    super.key,
    required this.onPressed,
    required this.buttonStyle,
    required this.buttonContent,
  });

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => setState(() => _pressed = true),
      onPointerUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Material(
          color: _pressed
              ? widget.buttonStyle.background.withValues(alpha: 0.85)
              : widget.buttonStyle.background,
          borderRadius: widget.buttonStyle.borderRadius,
          child: InkWell(
            borderRadius: widget.buttonStyle.borderRadius,
            splashColor: Colors.white.withValues(alpha: 0.15),
            highlightColor: Colors.white.withValues(alpha: 0.08),
            onTap: widget.onPressed,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              constraints: const BoxConstraints(minHeight: 80),
              child: widget.buttonContent,
            ),
          ),
        ),
      ),
    );
  }
}