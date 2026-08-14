import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/button_content/button_content.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/main_button_styles/button_style.dart';

class DoubleTextButtonContent extends ButtonContent {
  final String label;
  final String text;

  DoubleTextButtonContent({
    super.key,
    required this.label,
    required this.text,
    required AbstractButtonStyle style,
    Widget? before,
    Widget? after,
    icon
  }) : super(
          before: before,
          after: after,
          leading: _buildLeading(label, text, style),
          style: style,
          icon: icon
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