import 'package:flutter/material.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/button_style.dart';

class NormalButtonStyle extends AbstractButtonStyle {
  @override
  Color get background => ApplicationState().theme.primary300Color;

  @override
  BorderRadius get borderRadius => ApplicationState().theme.borderRadius;

  @override
  Color get foreground => const Color.fromARGB(255, 2, 21, 61);
  
  @override
  Color get accent => ApplicationState().theme.primary200Color;
}