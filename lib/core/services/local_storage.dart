import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ***** save local token ********//
  static Future<void> saveToken(String token) async {
    await _prefs?.setString("auth_token", token);
  }

  // ***** save local token ********//
  static Future<void> saveWalletId(String walletId) async {
    await _prefs?.setString("wallet_id", walletId);
  }

 // **** retrieve token from local storage *****//
  static String? getWalletId() {
    return _prefs?.getString("wallet_id");
  }
  // **** retrieve token from local storage *****//
  static String? getToken() {
    return _prefs?.getString("auth_token");
  }

  // ********* clear token *********** //
  Future<void> clearToken() async {
    await _prefs?.remove("auth_token");
  }
}
