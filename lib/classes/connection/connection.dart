import 'package:flutter/foundation.dart';

class Connection extends ChangeNotifier {
  bool isConnected = false;
  String vpnName = 'WeltraumVPN';
  String interfaceName = 'wg0';
  String status = 'None';

  void changeState() {
    isConnected = !isConnected;
    notifyListeners();
  }
}