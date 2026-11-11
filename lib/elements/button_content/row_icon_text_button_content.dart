import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weltraum/elements/button_content/button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/button_style.dart';

class RowIconTextButtonContent extends ButtonContent {
  final String label;

  RowIconTextButtonContent({
    super.key,
    required this.label,
    required super.style,
    required dynamic icon,
  }) : super(
          leading: _buildLeading(label, style, icon),
          isCenter: true,
        );

  static Widget _buildLeading(
    String label,
    AbstractButtonStyle style,
    dynamic icon,
  ) {
    final Color color = style.foreground;

    Widget iconWidget;

    if (icon is String) {
      iconWidget = SvgPicture.asset(
        icon,
        width: 32,
        height: 32,
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
      );
    } else if (icon is IconData) {
      iconWidget = Icon(
        icon,
        size: 32,
        color: color,
      );
    } else {
      throw ArgumentError(
        'icon must be either String (SVG path) or IconData',
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        iconWidget,
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color.withValues(alpha: 0.7),
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}