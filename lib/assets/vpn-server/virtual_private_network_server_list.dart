import 'package:weltraum/assets/vpn-server/virtual_private_netwrok_server.dart';

final Map<String, VirtualPrivateNetworkServer> servers = {
  "France_Lautenbourg": VirtualPrivateNetworkServer(
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
      """, 
      countryCode: 'FR', 
      type: ServerType.Free
    ),
    // "Germany_Berlin": VirtualPrivateNetworkServer(
    // serverAddress: "169.58.134.146:51820",
    // flag: "lib/assets/icons/flags/germany.svg",
    // city: "Berlin",
    // country: "Germany",
    // configuration: """
    //     [Interface]
    //     PrivateKey = kO/J+fzC56fw7YzrH9upVuc7RszBENGu9U99DPALs0E=
    //     Address = 10.0.0.2/32
    //     DNS = 8.8.8.8, 8.8.4.4

    //     [Peer]
    //     PublicKey = s/FexR9aa5uDPg4zYVc+JdzC5LdyevE/RI7hlQkT7RM=
    //     AllowedIPs = 0.0.0.0/0
    //     Endpoint = 169.58.134.146:51820
    //     PersistentKeepalive = 25
    //   """, 
    //   countryCode: 'GE', 
    //   type: ServerType.Free
    // ),
    "USA_Saint_Louis": VirtualPrivateNetworkServer(
    serverAddress: "62.146.183.147:51820",
    flag: "lib/assets/icons/flags/united_states_of_america.svg",
    city: "Saint Louis",
    country: "USA",
    configuration: """
        [Interface]
        PrivateKey = cDMl9QgQpsdV/vKHyGq7UFknzmIsP7TZBbrSqQvR5mI=
        Address = 10.0.0.2/24
        DNS = 8.8.8.8, 8.8.4.4
        MTU = 1460

        [Peer]
        PublicKey = x8tio0bb8xKrBWxTZLiS1Z6nvLJ3WAba+egAbyLzJHA=
        AllowedIPs = 0.0.0.0/0
        Endpoint = 62.146.183.147:51820
        PersistentKeepalive = 25
      """, 
      countryCode: 'US', 
      type: ServerType.Premium
    ),
};