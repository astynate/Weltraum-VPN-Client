import 'dart:ui';

import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => HeaderState();
}

class HeaderState extends State<Header>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  bool menuOpen = false;

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );
  }

  void toggleMenu() {
    if (menuOpen) {
      closeMenu();
    } else {
      openMenu();
    }
  }

  void openMenu() {
    setState(() {
      menuOpen = true;
    });

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return _buildMenuOverlay();
      },
    );

    Overlay.of(context).insert(_overlayEntry!);

    _controller.forward();
  }

  void closeMenu() {
    _controller.reverse().then((_) {
      if (!mounted) return;

      _overlayEntry?.remove();
      _overlayEntry = null;

      setState(() {
        menuOpen = false;
      });
    });
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: SafeArea(
        bottom: false,
        child: _buildHeader(),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 22,
                ),
                SizedBox(width: 3),
                Text(
                  'Weltraum®',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),
          const Spacer(),

          createHeaderMenuButton(),
        ],
      ),
    );
  }

  PressableScale createHeaderMenuButton() {
    return PressableScale(
      scale: 0.90,
      borderRadius: BorderRadius.circular(30),
      onTap: toggleMenu,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: .12),
        ),
        child: AnimatedRotation(
          turns: menuOpen ? .125 : 0,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutBack,
          child: Icon(
            menuOpen ? Icons.close : Icons.menu,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOverlay() {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 30,
              sigmaY: 30,
            ),
          child: Container(
            color: const Color(0xFF29106A).withValues(alpha: 0.5),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 20, 16, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _menuHeader(),
                        ),
          
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
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
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
      onTap: closeMenu,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: .15),
          // border: Border.all(
          //   color: Colors.white.withValues(alpha: .15),
          // ),
        ),
        child: const Icon(
          Icons.close,
          color: Colors.white70,
          size: 28,
        ),
      ),
    );
  }

  Widget _animatedMenuItem({
    required String text,
    required int index,
  }) {
    final start = (index * .08).clamp(0.0, .6);
    final end = (start + .45).clamp(0.0, 1.0);

    final animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        start,
        end,
        curve: Curves.easeOutBack,
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(
              -35 * (1 - animation.value),
              0,
            ),
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
      onTap: () {
        debugPrint('$text clicked');
      },
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

class PressableScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  final BorderRadius borderRadius;

  const PressableScale({
    super.key,
    required this.child,
    required this.onTap,
    this.scale = 0.96,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;

    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      onTapDown: (_) {
        _setPressed(true);
      },

      onTapUp: (_) {
        _setPressed(false);
      },

      onTapCancel: () {
        _setPressed(false);
      },

      onTap: widget.onTap,

      child: AnimatedScale(
        scale: _pressed ? widget.scale : 1.0,
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOutCubic,

        child: Material(
          color: Colors.transparent,
          borderRadius: widget.borderRadius,

          child: InkWell(
            borderRadius: widget.borderRadius,
            splashColor: Colors.white.withValues(alpha: .16),
            highlightColor: Colors.white.withValues(alpha: .07),
            onTap: widget.onTap,

            child: widget.child,
          ),
        ),
      ),
    );
  }
}