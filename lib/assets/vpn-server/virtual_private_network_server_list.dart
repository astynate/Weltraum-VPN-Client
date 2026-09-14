import 'package:flutter_app/assets/vpn-server/virtual_private_netwrok_server.dart';

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
    "France_Lautenbourg2": VirtualPrivateNetworkServer(
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
    "Germany_Hambourg": VirtualPrivateNetworkServer(
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
      """, 
      countryCode: 'GE', 
      type: ServerType.Premium
    ),
    "Germany_H": VirtualPrivateNetworkServer(
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
      """, 
      countryCode: 'GE', 
      type: ServerType.Premium
    ),
    "Germany_H2": VirtualPrivateNetworkServer(
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
      """, 
      countryCode: 'GE', 
      type: ServerType.Premium
    ),
    "Germany_H3": VirtualPrivateNetworkServer(
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
      """, 
      countryCode: 'GE', 
      type: ServerType.Premium
    ),
    "Germany_H9": VirtualPrivateNetworkServer(
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
      """, 
      countryCode: 'GE', 
      type: ServerType.Premium
    ),
    "Germany_H6": VirtualPrivateNetworkServer(
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
      """, 
      countryCode: 'GE', 
      type: ServerType.Premium
    ),
    "Germany_H7": VirtualPrivateNetworkServer(
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
      """, 
      countryCode: 'GE', 
      type: ServerType.Premium
    ),
};