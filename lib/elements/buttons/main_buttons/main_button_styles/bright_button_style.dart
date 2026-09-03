import 'package:flutter/material.dart';
import 'package:flutter_app/classes/application/application_state.dart';
import 'package:flutter_app/elements/buttons/main_buttons/main_button_styles/button_style.dart';

class BrightButtonStyle extends AbstractButtonStyle {
  @override
  Color get background => ApplicationState().theme.primary600Color;

  @override
  BorderRadius get borderRadius =>  ApplicationState().theme.borderRadius;

  @override
  Color get foreground => ApplicationState().theme.primary300Color;
  
  @override
  Color get accent => ApplicationState().theme.primary300Color;
}