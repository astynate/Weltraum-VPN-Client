import 'package:flutter/material.dart';
import 'package:flutter_app/classes/application/application_state.dart';
import 'package:wireguard_flutter_plus/wireguard_flutter_plus.dart';

class VirtualPrivateNetworkOperator extends ChangeNotifier {
  static String serverAddress = '';
  static String wgQuickConfig = '';
  static String providerBundleIdentifier = '';

  final vpn = WireGuardFlutter.instance;
  late final ApplicationState state;

  VirtualPrivateNetworkOperator(ApplicationState currentState) {
    state = currentState;

    vpn.vpnStageSnapshot.listen((event) {
      state.connection.status = "$event";
      notifyListeners();
    });

    initializeVirtualPrivateNetwork();
  }

  Future<void> initializeVirtualPrivateNetwork() async {
    await vpn.initialize(interfaceName: 'wg0', vpnName: 'Weltraum VPN');
  }

  Future<void> connect() async {
    // state.connection.status = "Connecting";

    VirtualPrivateNetworkOperator.serverAddress = "169.58.134.146:51820";
    VirtualPrivateNetworkOperator.wgQuickConfig = """
      [Interface]
      PrivateKey = kO/J+fzC56fw7YzrH9upVuc7RszBENGu9U99DPALs0E=
      Address = 10.0.0.2/32
      DNS = 8.8.8.8, 8.8.4.4

      [Peer]
      PublicKey = s/FexR9aa5uDPg4zYVc+JdzC5LdyevE/RI7hlQkT7RM=
      AllowedIPs = 0.0.0.0/0
      Endpoint = 169.58.134.146:51820
      PersistentKeepalive = 25
    """;

    VirtualPrivateNetworkOperator.providerBundleIdentifier = "com.example.app.WGExtension";

    await vpn.startVpn(
      serverAddress: VirtualPrivateNetworkOperator.serverAddress, 
      wgQuickConfig: VirtualPrivateNetworkOperator.wgQuickConfig, 
      providerBundleIdentifier: VirtualPrivateNetworkOperator.providerBundleIdentifier
    );

    // state.connection.status = "Connected";
  }

  Future<void> disconnect() async {
    // state.connection.status = "Disconnecting";
    // notifyListeners();

    await vpn.stopVpn();

    // state.connection.status = "Disconnected";
    // notifyListeners();
  }
}