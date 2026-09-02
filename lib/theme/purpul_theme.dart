import 'package:flutter/material.dart';
import 'package:flutter_app/theme/abstract_theme.dart';

class PurpulTheme extends AbstractTheme {
    // -- TO WRITE --
    @override
    Color get primary600Color => const Color(0xFFFFFFFF);
    
    // -- TO WRITE --
    @override
    Color get primary500Color => const Color.fromARGB(255, 134, 117, 177);
      
    @override
    Color get primary400Color => const Color.fromARGB(255, 60, 43, 111);
      
    @override
    Color get primary300Color => const Color.fromARGB(255, 101, 70, 194);
    
    @override
    Color get primary200Color => const Color.fromARGB(255, 77, 33, 187);
    
    @override
    Color get primary100Color => const Color.fromARGB(255, 52, 23, 125);
      
    @override
    Color get primary50Color => const Color.fromARGB(255, 39, 17, 94);
    
    @override
    Color get primary0Color => const Color.fromARGB(255, 0, 0, 0);

    @override
    Color get backgroundGradientStart => const Color.fromARGB(255, 100, 81, 154);
    
    @override
    Color get backgroundGradientEnd => const Color.fromRGBO(22, 10, 56, 1);
}