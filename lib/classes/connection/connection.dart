import 'package:flutter/foundation.dart';
import 'package:flutter_app/assets/vpn-server/virtual_private_netwrok_server.dart';

class Connection extends ChangeNotifier {
  bool isConnected = false;
  String vpnName = 'WeltraumVPN';
  String interfaceName = 'wg0';
  String status = 'None';
  VirtualPrivateNetworkServer? server;

  void changeState() {
    isConnected = !isConnected;
    notifyListeners();
  }
}