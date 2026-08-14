import 'package:flutter/material.dart';

class RouteOperator {
  static Future<T?> push<T>(
    BuildContext context,
    Widget page, {
    RouteTransitionsBuilder? transition,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: duration,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: transition ?? _defaultTransition,
      ),
    );
  }

  static Widget _defaultTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final fade = Tween<double>(begin: 0, end: 1).animate(animation);
    final slide = Tween<Offset>(
      begin: const Offset(0.05, 0),
      end: Offset.zero,
    ).animate(animation);

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: child,
      ),
    );
  }
}
