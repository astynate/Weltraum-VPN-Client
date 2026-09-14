import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/header/header.dart';

class ReturnButton extends StatefulWidget {
  final bool hasText;
  final VoidCallback? onPressed;

  const ReturnButton({
    super.key,
    this.hasText = false,
    this.onPressed,
  });

  @override
  State<ReturnButton> createState() => _ReturnButtonState();
}

class _ReturnButtonState extends State<ReturnButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      scale: 0.90,
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        widget.onPressed?.call();
        Navigator.of(context).maybePop();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(
              horizontal: widget.hasText ? 18 : 0,
            ),
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),

                // Optional text
                if (widget.hasText)
                  const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}