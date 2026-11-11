import 'package:flutter/material.dart';
import 'package:weltraum/elements/button_content/button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/button_style.dart';

class TextButtonContent extends ButtonContent {
  final String label;

  TextButtonContent({
    super.key,
    required this.label,
    required super.style,
    super.isCenter = true,
    super.before,
    super.after,
    super.icon,
  }) : super(
          leading: _buildLeading(label, style),
        );

  static Widget _buildLeading(String label, AbstractButtonStyle style) {
    return Text(
      label,
      style: TextStyle(
        color: style.foreground,
        fontSize: 19,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}