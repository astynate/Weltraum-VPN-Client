class VirtualPrivateNetworkServer {
  final String serverAddress;
  final String configuration;
  final String flag;
  final String country;
  final String city;
  final String countryCode;
  final ServerType type;

  VirtualPrivateNetworkServer({
    required this.serverAddress,
    required this.configuration,
    required this.flag, 
    required this.country, 
    required this.city,
    required this.countryCode,
    required this.type
  });
}

enum ServerType {
  Free,
  Premium,
  Professional,
}