import 'package:flutter/material.dart';
import 'package:weltraum/assets/vpn-server/virtual_private_netwrok_server.dart';
import 'package:weltraum/classes/account/account.dart';
import 'package:weltraum/classes/connection/connection.dart';
import 'package:weltraum/theme/abstract_theme.dart';
import 'package:weltraum/theme/purpul_theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApplicationState extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  String? accessToken;
  String? refreshToken;
  Account? account;
  AbstractTheme theme = PurpulTheme();
  Connection connection = Connection();

  void setServer(VirtualPrivateNetworkServer server) {
    connection.server = server;
    notifyListeners();
  }

  void login(Account inputAccount, String inputAccessToken, String inputRefreshToken) {
    account = inputAccount;
    accessToken = inputAccessToken;
    refreshToken = inputRefreshToken;
    
    notifyListeners();
  }

  void logout() {
    account = null;
    accessToken = null;
    refreshToken = null;
    
    notifyListeners();
  }

  void changeConnectionState(bool connectionState) {
    connection.isConnected = connectionState;
    notifyListeners();
  }

  Future<void> loadAccessToken() async {
    accessToken = await storage.read(key: 'accessToken');
  }

  Future<void> loadRefreshToken() async {
    refreshToken = await storage.read(key: 'refreshToken');
  }

  ApplicationState() {
    connection.addListener(notifyListeners);
  }

  Future<void> saveTokens(String inputAccessToken, String inputRefreshToken) async {
    accessToken = inputAccessToken;
    refreshToken = inputRefreshToken;

    await storage.write(key: 'accessToken', value: inputAccessToken);
    await storage.write(key: 'refreshToken', value: inputRefreshToken);

    notifyListeners();
  }

  Future<void> clearTokens() async {
    accessToken = null;
    refreshToken = null;

    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');

    notifyListeners();
  }

  void setAccount(Account inputAccount) {
    account = inputAccount;
    notifyListeners();
  }

  void setConnection (Connection inputConnection) {
    connection = inputConnection;
    notifyListeners();
  }
}