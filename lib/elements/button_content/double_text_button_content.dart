import 'package:flutter/material.dart';
import 'package:weltraum/elements/button_content/button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/button_style.dart';

class DoubleTextButtonContent extends ButtonContent {
  final String label;
  final String text;

  DoubleTextButtonContent({
    super.key,
    required this.label,
    required this.text,
    required super.style,
    super.hasBorder = false,
    super.before,
    super.after,
    super.icon
  }) : super(
          leading: _buildLeading(label, text, style),
        );

  static Widget _buildLeading(
    String label,
    String text,
    AbstractButtonStyle style,
  ) 
  {
    final Color color = style.foreground;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: color.withValues(alpha: 0.7),
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}