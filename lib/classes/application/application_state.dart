import 'package:flutter/material.dart';
import 'package:flutter_app/classes/account/account.dart';
import 'package:flutter_app/classes/connection/connection.dart';
import 'package:flutter_app/theme/abstract_theme.dart';
import 'package:flutter_app/theme/purpul_theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApplicationState extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  String? jwt;
  Account? user;
  AbstractTheme theme = PurpulTheme();
  Connection connection = Connection();

  Future<void> loadJwt() async {
    jwt = await storage.read(key: 'jwt');
  }

  Future<void> saveJwt(String token) async {
    jwt = token;
    await storage.write(key: 'jwt', value: token);
    notifyListeners();
  }

  Future<void> clearJwt() async {
    jwt = null;
    user = null;
    await storage.delete(key: 'jwt');
    notifyListeners();
  }

  void setUser(Account u) {
    user = u;
    notifyListeners();
  }

  void setConnection (Connection inputConnection) {
    connection = inputConnection;
  }
}