import 'package:flutter/material.dart';
import 'package:weltraum/assets/vpn-server/virtual_private_network_server_list.dart';
import 'package:weltraum/assets/vpn-server/virtual_private_netwrok_server.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:weltraum/elements/button_content/double_text_button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/button.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/button_style.dart';
import 'package:weltraum/elements/buttons/return_button/return_button.dart';
import 'package:weltraum/operators/virtual_private_network_operator.dart';
import 'package:weltraum/widgets/menu_button/menu_button.dart';
import 'package:weltraum/widgets/menu_button/menu_controller.dart';
import 'package:provider/provider.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen>
    with SingleTickerProviderStateMixin {

  late final HeaderMenuController menuController;

  @override
  void initState() {
    super.initState();
    menuController = HeaderMenuController(this);
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  Future<void> connectToServer(ApplicationState state, VirtualPrivateNetworkServer server) async {
    VirtualPrivateNetworkOperator operator = VirtualPrivateNetworkOperator(state);
    
    await operator.disconnect();

    state.setServer(server);

    if (context.mounted) {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    ApplicationState state = context.watch<ApplicationState>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 104, 73, 191),
              Color.fromARGB(255, 8, 1, 29),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                const ReturnButton(),
                                const Spacer(),
                                const Text("Locations", style: TextStyle(fontSize: 24, fontWeight: FontWeight(600)),),
                                const Spacer(),
                                HeaderMenuButton(controller: menuController),
                              ],
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: ApplicationState().theme.borderRadius,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                            child: const Row(
                              children: [
                                Icon(Icons.search, color: Colors.white70),
                                SizedBox(width: 6),
                                Expanded(
                                  child: TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: 'Search location',
                                      hintStyle: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 17,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: _sectionHeader(
                                title: 'Free',
                                speedLabel: '250 KB/S',
                              ),
                            ),
                    
                            const SizedBox(height: 5),
                    
                            for (var server in servers.values)
                              if (server.type == ServerType.Free) ...[
                                MainButton(
                                  onPressed: () {
                                    connectToServer(state, server);
                                  },
                                  buttonStyle: LocationButtonStyle(),
                                  buttonContent: DoubleTextButtonContent(
                                    label: "${server.city}, ${server.countryCode}",
                                    text: server.type.name,
                                    icon: server.flag,
                                    style: LocationButtonStyle(),
                                  ),
                                ),
                                const SizedBox(height: 3),
                              ],
                    
                              const SizedBox(height: 12),
                      
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: _sectionHeader(
                                  title: 'Premium',
                                  speedLabel: '5 MB/S',
                                ),
                              ),
                      
                              const SizedBox(height: 5),
                      
                              for (var server in servers.values)
                                if (server.type == ServerType.Premium) ...[
                                  MainButton(
                                    onPressed: () {
                                      connectToServer(state, server);
                                    },
                                    buttonStyle: LocationButtonStyle(),
                                    buttonContent: DoubleTextButtonContent(
                                      label: "${server.city}, ${server.countryCode}",
                                      text: server.type.name,
                                      icon: server.flag,
                                      style: LocationButtonStyle(),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                ],

                                const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader({required String title, required String speedLabel}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            speedLabel,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class LocationTile extends StatefulWidget {
  final VirtualPrivateNetworkServer server;

  const LocationTile({
    super.key,
    required this.server,
  });

  @override
  State<LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> {
  bool _hover = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() {
        _hover = false;
        _pressed = false;
      }),

      child: Listener(
        onPointerDown: (_) => setState(() => _pressed = true),
        onPointerUp: (_) => setState(() => _pressed = false),

        child: AnimatedScale(
          scale: _pressed ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,

          child: Material(
            color: _pressed
                ? Colors.white.withValues(alpha: 0.10)
                : _hover
                    ? Colors.white.withValues(alpha: 0.07)
                    : Colors.white.withValues(alpha: 0.05),

            borderRadius: BorderRadius.circular(16),

            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              splashColor: Colors.white.withValues(alpha: 0.1),
              highlightColor: Colors.white.withValues(alpha: 0.05),

              onTap: () {
                print("Clicked!");
              },

              child: Container(
                height: 70,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text("Location Tile"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class LocationButtonStyle extends AbstractButtonStyle {
  @override
  Color get background => const Color.fromRGBO(255, 255, 255, 0.07);

  @override
  BorderRadius get borderRadius => ApplicationState().theme.borderRadius;

  @override
  Color get foreground => const Color.fromRGBO(255, 255, 255, 1);

  @override
  Color get accent => const Color.fromARGB(255, 104, 73, 191);
}