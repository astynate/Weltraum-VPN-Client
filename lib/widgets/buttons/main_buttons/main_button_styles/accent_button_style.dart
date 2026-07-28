import 'package:flutter/material.dart';
import 'package:flutter_app/classes/application/application_state.dart';
import 'package:flutter_app/widgets/buttons/main_buttons/main_button_styles/button_style.dart';

class AccentButtonStyle extends AbstractButtonStyle {
  @override
  Color get background => ApplicationState().theme.primary600Color;

  @override
  BorderRadius get borderRadius => throw UnimplementedError();

  @override
  Color get foreground => throw UnimplementedError();
  
  @override
  Color get accent => throw UnimplementedError();
}