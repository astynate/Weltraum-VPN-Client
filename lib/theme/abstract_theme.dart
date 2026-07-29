import 'package:flutter/material.dart';

abstract class AbstractTheme {
  // Colours
  Color primary600Color = const Color(0xFFFFFFFF);
  Color primary500Color = const Color.fromARGB(255, 134, 117, 177);
  Color primary400Color = const Color(0x003c2b6f);
  Color primary300Color = const Color(0x006446c2);
  Color primary200Color = const Color(0x004d21bb);
  Color primary100Color = const Color(0x0034177d);
  Color primary50Color = const Color(0x0027115e);
  Color primary0Color = const Color(0x00000000);

  // Anthing Else
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(15));
}