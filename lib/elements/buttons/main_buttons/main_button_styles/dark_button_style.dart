import 'package:flutter/material.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/button_style.dart';

class DarkButtonStyle extends AbstractButtonStyle {
  @override
  Color get background => const Color.fromARGB(75, 0, 0, 0);

  @override
  BorderRadius get borderRadius =>  ApplicationState().theme.borderRadius;

  @override
  Color get foreground => Colors.white;
  
  @override
  Color get accent => ApplicationState().theme.primary300Color;
}