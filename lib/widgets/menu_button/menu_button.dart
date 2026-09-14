import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/header/header.dart';
import 'package:flutter_app/widgets/menu_button/menu_controller.dart';

class HeaderMenuButton extends StatelessWidget {
  final HeaderMenuController controller;

  const HeaderMenuButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      scale: 0.90,
      borderRadius: BorderRadius.circular(30),
      onTap: () => controller.toggle(context),
      child: AnimatedBuilder(
        animation: controller.animation,
        builder: (_, __) {
          final open = controller.isOpen;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: .12),
            ),
            child: AnimatedRotation(
              turns: open ? .125 : 0,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutBack,
              child: const Icon(
                // open ? Icons.close : Icons.menu,
                Icons.menu,
                color: Colors.white,
                size: 28,
              ),
            ),
          );
        },
      ),
    );
  }
}