import 'dart:async';
import 'package:flutter_app/api/account_api.dart';
import 'package:flutter_app/classes/account/account.dart';
import 'package:flutter_app/classes/application/application_state.dart';

class JasonWebTokenOperator {
  Future<bool> setUpUser(ApplicationState state) async {
    await state.loadJwt();

    AccountAPI accountAPI = AccountAPI();

    // Case 1: No JWT stored → return false
    if (state.jwt == null) {
      return false;
    }

    // Case 2: JWT exists → try to fetch user
    Account? user = await accountAPI.fetchUser(state.jwt!);

    if (user != null) {
      state.setUser(user);
      return true;
    }

    // Case 3: JWT invalid → clear it and return false
    await state.clearJwt();
    return false;
  }
}