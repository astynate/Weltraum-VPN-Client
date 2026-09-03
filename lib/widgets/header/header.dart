import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  bool menuOpen = false;

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
    setState(() {
      menuOpen = !menuOpen;
    });

    if (menuOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        color: const Color.fromARGB(0, 255, 255, 255),
        child: SafeArea(
          child: Stack(
            children: [
              _buildHeader(),

              if (menuOpen) _buildMenu(),
            ],
          ),
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

          // Menu button
          GestureDetector(
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
          ),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    final items = [
      'Profile',
      'Settings',
      'Language',
      'Theme',
      'Switch',
      'Logout',
    ];

    return Positioned.fill(
      child: Container(
        color: const Color(0xFF29106A).withValues(alpha: .96),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 20, 16, 0),
          child: Column(
            children: [
              // Top close/header
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
                  itemCount: items.length,
                  itemBuilder: (context, index) {
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
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: .16),
              Colors.white.withValues(alpha: .10),
            ],
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: .15),
          ),
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
          'Menu',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _closeButton() {
    return GestureDetector(
      onTap: toggleMenu,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: .15),
          border: Border.all(
            color: Colors.white.withValues(alpha: .15),
          ),
        ),
        child: const Icon(
          Icons.close,
          color: Colors.white70,
          size: 27,
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () {
          debugPrint('$text clicked');
        },
        child: Container(
          height: 51,
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
            border: Border.all(
              color: Colors.white.withValues(alpha: .15),
              width: 1,
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
      ),
    );
  }
}
