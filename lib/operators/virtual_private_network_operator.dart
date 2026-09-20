import 'package:flutter/material.dart';
import 'package:weltraum/classes/application/application_state.dart';
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
    if (state.connection.server == null) {
      return;
    }

    state.connection.status = "Connecting";
    notifyListeners();

    VirtualPrivateNetworkOperator.serverAddress = state.connection.server!.serverAddress;
    VirtualPrivateNetworkOperator.wgQuickConfig = state.connection.server!.configuration;

    VirtualPrivateNetworkOperator.providerBundleIdentifier = "com.example.app.WGExtension";

    await vpn.startVpn(
      serverAddress: VirtualPrivateNetworkOperator.serverAddress, 
      wgQuickConfig: VirtualPrivateNetworkOperator.wgQuickConfig, 
      providerBundleIdentifier: VirtualPrivateNetworkOperator.providerBundleIdentifier
    );

    state.connection.changeState(); 
    state.connection.status = "Connected";

    notifyListeners();
  }

  Future<void> disconnect() async {
    state.connection.status = "Disconnecting";
    notifyListeners();

    await vpn.stopVpn();

    state.connection.status = "Disconnected";
    state.connection.changeState(); 
    notifyListeners();
  }
}