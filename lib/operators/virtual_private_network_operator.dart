import 'package:wireguard_flutter_plus/wireguard_flutter_plus.dart';

class VirtualPrivateNetworkOperator {
  static String serverAddress = '';
  static String wgQuickConfig = '';
  static String providerBundleIdentifier = '';

  final vpn = WireGuardFlutter.instance;

  Future<void> initializeVirtualPrivateNetwork() async {
    await vpn.initialize(interfaceName: 'wg0', vpnName: 'Weltraum VPN');
  }

  Future<void> connect() async {
    await vpn.startVpn(
      serverAddress: VirtualPrivateNetworkOperator.serverAddress, 
      wgQuickConfig: VirtualPrivateNetworkOperator.wgQuickConfig, 
      providerBundleIdentifier: VirtualPrivateNetworkOperator.providerBundleIdentifier
    );
  }

  Future<void> disconnect() async {
    await vpn.stopVpn();
  }
}