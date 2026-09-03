import 'package:flutter_app/assets/vpn-server/virtual_private_netwrok_server.dart';

final Map<String, VirtualPrivateNetwrokServer> vpnServers = {
  "France_Lautenbourg": VirtualPrivateNetwrokServer(
    serverAddress: "169.58.134.146:51820",
    flag: "lib/assets/icons/flags/france.svg",
    city: "Lautenbourg",
    country: "France",
    configuration: """
        [Interface]
        PrivateKey = kO/J+fzC56fw7YzrH9upVuc7RszBENGu9U99DPALs0E=
        Address = 10.0.0.2/32
        DNS = 8.8.8.8, 8.8.4.4

        [Peer]
        PublicKey = s/FexR9aa5uDPg4zYVc+JdzC5LdyevE/RI7hlQkT7RM=
        AllowedIPs = 0.0.0.0/0
        Endpoint = 169.58.134.146:51820
        PersistentKeepalive = 25
      """
    ),
    "Germany_Hambourg": VirtualPrivateNetwrokServer(
    serverAddress: "169.58.134.146:51820",
    flag: "lib/assets/icons/flags/germany.svg",
    city: "Hambourg",
    country: "Germany",
    configuration: """
        [Interface]
        PrivateKey = kO/J+fzC56fw7YzrH9upVuc7RszBENGu9U99DPALs0E=
        Address = 10.0.0.2/32
        DNS = 8.8.8.8, 8.8.4.4

        [Peer]
        PublicKey = s/FexR9aa5uDPg4zYVc+JdzC5LdyevE/RI7hlQkT7RM=
        AllowedIPs = 0.0.0.0/0
        Endpoint = 169.58.134.146:51820
        PersistentKeepalive = 25
      """
    ),
};