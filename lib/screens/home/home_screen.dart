import 'package:flutter/material.dart';
import 'package:weltraum/assets/vpn-server/virtual_private_network_server_list.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/button_style.dart';
import 'package:weltraum/operators/route_operator.dart';
import 'package:weltraum/operators/virtual_private_network_operator.dart';
import 'package:weltraum/screens/locations/locations_screen.dart';
import 'package:weltraum/elements/button_content/double_text_button_content.dart';
import 'package:weltraum/elements/button_content/text_button_content.dart';
import 'package:weltraum/elements/buttons/main_buttons/button.dart';
import 'package:weltraum/elements/buttons/main_buttons/main_button_styles/accent_button_style.dart';
import 'package:weltraum/widgets/header/header.dart';
import 'package:provider/provider.dart';
import 'package:weltraum/widgets/map/server_map.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const double mobileBreakpoint = 600;
  static const double desktopPanelWidth = 350;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final state = context.read<ApplicationState>();

      if (state.connection.server == null) {
        state.setServer(servers.values.first);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ApplicationState>();
    final operator = VirtualPrivateNetworkOperator(state);

    if (state.connection.server == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    state.theme.backgroundGradientStart,
                    state.theme.backgroundGradientEnd,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.75],
                ),
              ),
            ),
          ),

          const Positioned.fill(
            child: ServerMap(),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile =
                    constraints.maxWidth < HomeScreen.mobileBreakpoint;

                return Column(
                  children: [
                    _buildTopPanel(isMobile),

                    const Expanded(
                      child: SizedBox.expand(),
                    ),

                    _buildBottomPanel(
                      context,
                      state,
                      operator,
                      isMobile,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPanel(bool isMobile) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 0,
          vertical: 0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 0 : 0,
          vertical: 0,
        ),
        decoration: BoxDecoration(
          // color: Colors.black.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(
          //   color: Colors.white.withValues(alpha: 0.12),
          // ),
        ),
        child: const Header(),
      ),
    );
  }

  Widget _buildBottomPanel(
    BuildContext context,
    ApplicationState state,
    VirtualPrivateNetworkOperator operator,
    bool isMobile,
  ) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: isMobile ? null : HomeScreen.desktopPanelWidth,
        margin: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 24,
          vertical: isMobile ? 60 : 12,
        ),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.12),
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: isMobile ? 0 : 0,
            maxWidth: isMobile ? 350 : HomeScreen.desktopPanelWidth,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLocationButton(context, state),
              const SizedBox(height: 8),
              _buildConnectButton(state, operator),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildConnectButton(
    ApplicationState state,
    VirtualPrivateNetworkOperator operator,
  ) {
    return MainButton(
      onPressed: () {
        if (state.connection.isConnected) {
          operator.disconnect();
        } else {
          operator.connect();
        }
      },
      buttonStyle: AccentButtonStyle(),
      buttonContent: TextButtonContent(
        label: state.connection.isConnected
            ? "Disconnect"
            : "Connect",
        style: AccentButtonStyle(),
      ),
    );
  }

  Widget _buildLocationButton(
    BuildContext context,
    ApplicationState state,
  ) {
    final server = state.connection.server!;

    return MainButton(
      onPressed: () {
        RouteOperator.push(
          context,
          const LocationsScreen(),
        );
      },
      buttonStyle: BottomButtonStyle(),
      buttonContent: DoubleTextButtonContent(
        label: "${server.city}, ${server.country}",
        text: state.connection.isConnected
            ? "Active"
            : "Passive",
        style: BottomButtonStyle(),
        icon: server.flag,
        hasBorder: true,
      ),
    );
  }
}

class BottomButtonStyle extends AbstractButtonStyle {
  @override
  Color get background =>const Color.fromRGBO(255, 255, 255, 0.15);

  @override
  BorderRadius get borderRadius => ApplicationState().theme.borderRadius;

  @override
  Color get foreground =>const Color.fromRGBO(255, 255, 255, 1);

  @override
  Color get accent =>const Color.fromARGB(255, 104, 73, 191);
}