import 'package:flutter/material.dart';

abstract class AbstractButtonStyle {
  Color get background;
  Color get foreground;
  Color get accent;
  BorderRadius get borderRadius;

  const AbstractButtonStyle();
}