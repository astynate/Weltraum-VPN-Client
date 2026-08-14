import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/button_content/button_content.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/main_button_styles/button_style.dart';

class TextButtonContent extends ButtonContent {
  final String label;

  TextButtonContent({
    super.key,
    required this.label,
    required AbstractButtonStyle style,
    Widget? before,
    Widget? after,
    icon,
  }) : super(
          before: before,
          after: after,
          leading: _buildLeading(label, style),
          style: style,
          isCenter: true,
          icon: icon,
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