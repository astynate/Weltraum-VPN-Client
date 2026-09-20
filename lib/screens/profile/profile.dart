import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int days = 128;
  bool switched = false;
  bool menuOpen = false;
  bool settingsOpen = false;
  bool editOpen = false;

  static const bgTop = Color(0xFF5B478D);
  static const bgBottom = Color(0xFF0D0135);
  static const panel = Color(0xFF30264E);
  static const panelLight = Color(0xFF51476B);
  static const white = Color(0xFFF8F7FC);
  static const muted = Color(0xFFAAA4B9);
  static const lavender = Color(0xFF8B7AB7);

  void toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1400),
          backgroundColor: const Color(0xFF3A2E59),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      );
  }

  void showLogout() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF30264E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: const Text('Log out', style: TextStyle(color: white, fontWeight: FontWeight.w700)),
        content: const Text('Do you want to log out?', style: TextStyle(color: muted)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF8170AF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(context);
              toast('Logged out');
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }

  void showTopUp() {
    setState(() => days += 30);
    toast('+30 days added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: _Background()),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CircleButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () => toast('Back'),
                      ),
                      _CircleButton(
                        icon: Icons.menu_rounded,
                        onTap: () => setState(() => menuOpen = true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  ClipOval(
                    child: Image.asset(
                      'assets/avatar.png',
                      width: 78,
                      height: 78,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    switched ? 'Alex Morgan' : 'Nathan Hartley',
                    style: const TextStyle(
                      color: white, fontSize: 16, fontWeight: FontWeight.w700, height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    switched ? 'alex.morgan@example.com' : 'name.surname@gmail.com',
                    style: const TextStyle(color: muted, fontSize: 10.5, height: 1.1),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: _ActionButton(
                        icon: Icons.edit_rounded,
                        label: 'Edit',
                        onTap: () => setState(() => editOpen = true),
                      )),
                      const SizedBox(width: 6),
                      Expanded(child: _ActionButton(
                        icon: Icons.sync_alt_rounded,
                        label: 'Switch',
                        onTap: () => setState(() => switched = !switched),
                      )),
                      const SizedBox(width: 6),
                      Expanded(child: _ActionButton(
                        icon: Icons.logout_rounded,
                        label: 'Logout',
                        onTap: showLogout,
                      )),
                    ],
                  ),
                  const SizedBox(height: 13),
                  _WideButton(
                    icon: Icons.settings_rounded,
                    label: 'Settings',
                    onTap: () => setState(() => settingsOpen = true),
                  ),
                  const SizedBox(height: 12),
                  _PremiumCard(
                    days: days,
                    onTopUp: showTopUp,
                  ),
                  const SizedBox(height: 66),
                  const Text(
                    'Instant LLC, California USA',
                    style: TextStyle(color: white, fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    '© Copyright 2026. All rights are reserved.',
                    style: TextStyle(color: Color(0xFF69627A), fontSize: 8),
                  ),
                  const SizedBox(height: 11),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.asset('assets/footer_flags.png', width: 66, height: 20, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Made and Certified in the EU.',
                    style: TextStyle(color: Color(0xFF69627A), fontSize: 8),
                  ),
                ],
              ),
            ),
          ),
          if (menuOpen) _OverlayMenu(
            onClose: () => setState(() => menuOpen = false),
            onItem: (item) {
              setState(() => menuOpen = false);
              toast(item);
            },
          ),
          if (settingsOpen) _SettingsSheet(
            onClose: () => setState(() => settingsOpen = false),
            onTap: (item) => toast(item),
          ),
          if (editOpen) _EditDialog(
            name: switched ? 'Alex Morgan' : 'Nathan Hartley',
            email: switched ? 'alex.morgan@example.com' : 'name.surname@gmail.com',
            onClose: () => setState(() => editOpen = false),
            onSaved: (name, email) {
              setState(() => editOpen = false);
              toast('Profile saved');
            },
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_ProfileScreenState.bgTop, _ProfileScreenState.bgBottom],
          stops: [0.0, 0.56],
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, const Color(0xCC09002A)],
            stops: const [.35, 1],
          ),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: const BoxDecoration(
          color: Color(0x557D6BAA),
          shape: BoxShape.circle,
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 38, height: 38,
            child: Icon(icon, color: Colors.white, size: 22),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(22),
      child: Ink(
        decoration: BoxDecoration(
          color: const Color(0xFF4B3F68),
          borderRadius: BorderRadius.circular(22),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: SizedBox(
            height: 43,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: Colors.white),
                const SizedBox(width: 7),
                Text(label, style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WideButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _WideButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          color: const Color(0xFF352A53),
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: const SizedBox(
            height: 43,
            child: Row(
              children: [
                SizedBox(width: 13),
                Icon(Icons.settings_rounded, color: Colors.white, size: 20),
                SizedBox(width: 11),
                Text('Settings', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PremiumCard extends StatelessWidget {
  final int days;
  final VoidCallback onTopUp;
  const _PremiumCard({required this.days, required this.onTopUp});

  @override
  Widget build(BuildContext context) {
    const muted = Color(0xFFA9A2B8);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xCC352A53),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Premium', style: TextStyle(color: Colors.white, fontSize: 13.5, fontWeight: FontWeight.w800)),
          const SizedBox(height: 9),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 47,
                  decoration: BoxDecoration(
                    color: const Color(0xFF51476B),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      const Icon(Icons.star_rounded, color: Colors.white, size: 22),
                      const SizedBox(width: 7),
                      Text('$days Days', style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(13),
                child: Ink(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(13),
                    onTap: onTopUp,
                    child: const SizedBox(
                      width: 72, height: 47,
                      child: Center(child: Text('Top-up', style: TextStyle(color: Color(0xFF29213F), fontSize: 11, fontWeight: FontWeight.w800))),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          const Divider(height: 1, color: Color(0x445E5479)),
          const _Feature(text: 'Unlimited Connection', color: muted),
          const _Feature(text: '1 GB/S Servers', color: muted),
          const _Feature(text: '200 MB/S Servers', color: muted),
          const _Feature(text: 'Russian Firewall Protocols', color: muted),
          const _Feature(text: 'Game Server Finder', color: muted),
        ],
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  final String text;
  final Color color;
  const _Feature({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Text(text, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w400)),
    );
  }
}

class _OverlayMenu extends StatelessWidget {
  final VoidCallback onClose;
  final ValueChanged<String> onItem;
  const _OverlayMenu({required this.onClose, required this.onItem});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: onClose,
        child: Container(
          color: Colors.black.withOpacity(.25),
          child: Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 175,
                  margin: const EdgeInsets.fromLTRB(0, 57, 12, 0),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF332851),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [BoxShadow(blurRadius: 20, color: Colors.black54)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _MenuItem(icon: Icons.person_rounded, text: 'Profile', onTap: () => onItem('Profile')),
                      _MenuItem(icon: Icons.settings_rounded, text: 'Settings', onTap: () => onItem('Settings')),
                      _MenuItem(icon: Icons.help_outline_rounded, text: 'Help', onTap: () => onItem('Help')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 11),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.white),
              const SizedBox(width: 10),
              Text(text, style: const TextStyle(color: Colors.white, fontSize: 11.5)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSheet extends StatelessWidget {
  final VoidCallback onClose;
  final ValueChanged<String> onTap;
  const _SettingsSheet({required this.onClose, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: onClose,
        child: Container(
          color: Colors.black.withOpacity(.35),
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              decoration: const BoxDecoration(
                color: Color(0xFF30264E),
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 38, height: 4, decoration: BoxDecoration(color: const Color(0xFF716682), borderRadius: BorderRadius.circular(4))),
                  const SizedBox(height: 12),
                  const Align(alignment: Alignment.centerLeft, child: Text('Settings', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800))),
                  const SizedBox(height: 8),
                  _SettingRow(icon: Icons.notifications_none_rounded, text: 'Notifications', onTap: () => onTap('Notifications')),
                  _SettingRow(icon: Icons.language_rounded, text: 'Language', onTap: () => onTap('Language')),
                  _SettingRow(icon: Icons.shield_outlined, text: 'Privacy', onTap: () => onTap('Privacy')),
                  const SizedBox(height: 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const _SettingRow({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
              const Spacer(),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF9D95AE)),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditDialog extends StatefulWidget {
  final String name;
  final String email;
  final VoidCallback onClose;
  final void Function(String name, String email) onSaved;
  const _EditDialog({required this.name, required this.email, required this.onClose, required this.onSaved});

  @override
  State<_EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<_EditDialog> {
  late final TextEditingController name;
  late final TextEditingController email;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.name);
    email = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(.38),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(22),
        child: Material(
          color: const Color(0xFF30264E),
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Edit profile', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                ),
                const SizedBox(height: 14),
                _Field(controller: name, label: 'Name'),
                const SizedBox(height: 9),
                _Field(controller: email, label: 'Email'),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: widget.onClose, child: const Text('Cancel')),
                    const SizedBox(width: 4),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF8170AF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => widget.onSaved(name.text, email.text),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const _Field({required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 12),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFAAA2BA), fontSize: 11),
        filled: true,
        fillColor: const Color(0xFF44385F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}