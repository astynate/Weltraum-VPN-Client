import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/main_button_styles/button_style.dart';

class Button extends AbstractButtonStyle {
  const Button();

  @override
  Color get background => const Color(0xFF6C5CE7);

  @override
  Color get foreground => Colors.white;

  @override
  Border? get border => null;
  
  @override
  BorderRadius get borderRadius => throw UnimplementedError();
}