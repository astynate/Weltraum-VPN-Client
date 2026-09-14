import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/menu_button/header_menu.dart';

class HeaderMenuController {
  late AnimationController animation;
  OverlayEntry? entry;

  bool get isOpen => entry != null;

  HeaderMenuController(TickerProvider vsync) {
    animation = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 450),
    );
  }

  void open(BuildContext context) {
    if (isOpen) return;

    entry = OverlayEntry(
      builder: (_) => HeaderMenu(controller: this),
    );

    Overlay.of(context).insert(entry!);
    animation.forward();
  }

  void close() {
    if (!isOpen) return;

    animation.reverse().then((_) {
      entry?.remove();
      entry = null;
    });
  }

  void toggle(BuildContext context) {
    isOpen ? close() : open(context);
  }

  void dispose() {
    animation.dispose();
  }
}
