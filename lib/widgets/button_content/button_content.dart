import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/main_button_styles/button_style.dart';

class ButtonContent extends StatelessWidget {
  final Widget? leading;
  final Widget? before;
  final Widget? after;
  final AbstractButtonStyle style;
  final bool isCenter;

  final dynamic icon;

  const ButtonContent({
    super.key,
    this.before,
    this.after,
    this.icon,
    this.isCenter = false,
    required this.leading,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) _buildIcon(),
        if (icon != null) const SizedBox(width: 10),

        if (before != null) before!,
        if (leading != null) leading!,
        if (after != null) after!,
      ],
    );

    return isCenter ? Center(child: row) : row;
  }

  Widget _buildIcon() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 3,
        ),
      ),
      child: ClipOval(
        child: _resolveIcon(),
      ),
    );
  }

  Widget _resolveIcon() {
    if (icon is String) {
      return SvgPicture.asset(
        icon,
        width: 48,
        height: 48,
      );
    }

    if (icon is IconData) {
      return Icon(
        icon,
        size: 40,
        color: style.accent,
      );
    }

    return const SizedBox.shrink();
  }
}