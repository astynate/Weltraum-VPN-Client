import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/header/header.dart';
import 'package:flutter_app/widgets/menu_button/menu_controller.dart';

class HeaderMenu extends StatelessWidget {
  final HeaderMenuController controller;

  const HeaderMenu({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            color: const Color(0xFF29106A).withValues(alpha: 0.5),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 20, 16, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _menuHeader()),
                        const SizedBox(width: 12),
                        _closeButton(),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Expanded(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          const items = [
                            'Profile',
                            'Settings',
                            'Language',
                            'Theme',
                            'Switch',
                            'Logout',
                          ];

                          return _animatedMenuItem(
                            text: items[index],
                            index: index,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuHeader() {
    return AnimatedBuilder(
      animation: controller.animation,
      builder: (context, child) {
        return Opacity(
          opacity: controller.animation.value.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: 0.92 + (controller.animation.value * 0.08),
            alignment: Alignment.centerLeft,
            child: child,
          ),
        );
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .12),
              blurRadius: 10,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: const Text(
          '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _closeButton() {
    return PressableScale(
      scale: 0.88,
      borderRadius: BorderRadius.circular(30),
      onTap: controller.close,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: .15),
        ),
        child: const Icon(
          Icons.close,
          color: Colors.white70,
          size: 28,
        ),
      ),
    );
  }

  Widget _animatedMenuItem({required String text, required int index}) {
    final start = (index * .08).clamp(0.0, .6);
    final end = (start + .45).clamp(0.0, 1.0);

    final animation = CurvedAnimation(
      parent: controller.animation,
      curve: Interval(start, end, curve: Curves.easeOutBack),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(-35 * (1 - animation.value), 0),
            child: Transform.scale(
              scale: .95 + (.05 * animation.value),
              child: child,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: _menuButton(text),
      ),
    );
  }

  Widget _menuButton(String text) {
    return PressableScale(
      scale: 0.96,
      borderRadius: BorderRadius.circular(28),
      onTap: () => debugPrint('$text clicked'),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white.withValues(alpha: .15),
              Colors.white.withValues(alpha: .09),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .10),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}