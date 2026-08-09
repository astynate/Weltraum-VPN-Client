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
    VirtualPrivateNetworkOperator.serverAddress = "147.135.15.16:443";
    VirtualPrivateNetworkOperator.wgQuickConfig = """
      [Interface]
      PrivateKey = kO/J+fzC56fw7YzrH9upVuc7RszBENGu9U99DPALs0E=
      PublicKey = b2iTDPRsb8CrkQ1Dr8k3saGyvCvXmuQ1AX2siGXsJRk=
      Address = 10.0.0.2/24
      DNS = 8.8.8.8, 8.8.4.4
      MTU = 1460

      [Peer]
      PublicKey = s/FexR9aa5uDPg4zYVc+JdzC5LdyevE/RI7hlQkT7RM=
      AllowedIPs = 0.0.0.0/0
      Endpoint = 169.58.134.146:51820
    """;

    VirtualPrivateNetworkOperator.providerBundleIdentifier = "com.example.app.WGExtension";

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