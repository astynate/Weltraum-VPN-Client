import 'package:flutter/material.dart';
import 'package:flutter_app/classes/account/account.dart';
import 'package:flutter_app/classes/connection/connection.dart';
import 'package:flutter_app/theme/abstract_theme.dart';
import 'package:flutter_app/theme/purpul_theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApplicationState extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  String? accessToken;
  String? refreshToken;
  Account? account;
  AbstractTheme theme = PurpulTheme();
  Connection connection = Connection();

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