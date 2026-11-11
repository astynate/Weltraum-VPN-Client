import 'dart:convert';
import 'package:weltraum/classes/account/account.dart';
import 'package:weltraum/classes/application/application_configuration.dart';
import 'package:http/http.dart' as http;

class AccountAPI {
  // static Future<Account?> fetchUser(String jwt) async {
  //   final response = await http.get(
  //     Uri.parse("https://your-api.com/me"),
  //     headers: {
  //       "Authorization": "Bearer $jwt",
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     return Account.fromJson(jsonDecode(response.body));
  //   }

  //   return null;
  // }

  static Future<Account?> getAccountByEmailAsync(String email) async {
    final response = await http.get(
      Uri.parse("${ApplicationConfiguration().url}/api/accounts/email?email=$email"),
    );

    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  static Future<String?> createAnAccount(String fullname, String email, String? avatarPath, String? password) async {
      final uri = Uri.parse("${ApplicationConfiguration().url}/api/accounts");
      final request = http.MultipartRequest("POST", uri);

      request.fields["fullname"] = fullname;
      request.fields["email"] = email;

      if (avatarPath != null) {
        request.fields["avatarPath"] = avatarPath;
      }

      if (password != null) {
        request.fields["password"] = password;
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode == 200) {
        return response.body;
      }

      return null;
  }

  static Future<dynamic> authorizeWithGoogle(String email, String displayedName, String? avatarPath) async {
    Account? account = await getAccountByEmailAsync(email);

    if (account == null) {
      String? result = await createAnAccount(displayedName, email, avatarPath, null);

      if (result != null && jsonDecode(result) is Account) {
        return jsonDecode(result);
      }

      return null;
    }

    return null;
  }

  static Future<(Account? account, String? accessToken, String? refreshToken, bool result, String? error)> authorizeWithExternalID(String id, String provider) async {
    final uri = Uri.parse("${ApplicationConfiguration().url}/api/accounts/external");
    final request = http.MultipartRequest("POST", uri);
    
    request.fields["token"] = id;
    request.fields["provider"] = provider;

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode == 200) {
      final responseObject = jsonDecode(response.body) as Map<String, dynamic>;

      if (responseObject["account"] == null) {
        return (null, null, null, false, response.body);
      }

      final responseAccount = Account.fromJson(responseObject["account"]);
      final responseRefreshToken = responseObject["refreshToken"] as String?;
      final responseAccessToken = responseObject["accessToken"] as String?;

      return (
        responseAccount,
        responseAccessToken,
        responseRefreshToken,
        true,
        null,
      );
    }

    return (null, null, null, false, response.body);
  }
}