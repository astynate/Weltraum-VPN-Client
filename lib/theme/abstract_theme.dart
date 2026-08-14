import 'package:flutter/material.dart';

abstract class AbstractTheme {
  // Colours
  Color primary600Color = const Color(0xFFFFFFFF);
  Color primary500Color = const Color.fromARGB(255, 134, 117, 177);
  Color primary400Color = const Color.fromARGB(255, 60, 43, 111);
  Color primary300Color = const Color(0x006446c2);
  Color primary200Color = const Color.fromARGB(255, 77, 33, 187);
  Color primary100Color = const Color.fromARGB(255, 52, 23, 125);
  Color primary50Color = const Color.fromARGB(255, 39, 17, 94);
  Color primary0Color = const Color.fromARGB(255, 0, 0, 0);

  // Anthing Else
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(30));
}