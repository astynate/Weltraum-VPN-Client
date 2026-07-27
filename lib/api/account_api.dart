import 'dart:convert';
import 'package:flutter_app/classes/account/account.dart';
import 'package:http/http.dart' as http;

class AccountAPI {
  Future<Account?> fetchUser(String jwt) async {
    final response = await http.get(
      Uri.parse("https://your-api.com/me"),
      headers: {
        "Authorization": "Bearer $jwt",
      },
    );

    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    }

    return null;
  }
}