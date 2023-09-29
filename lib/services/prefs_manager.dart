import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  Future<void> storeUserId(String id) async {
    final sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.setString('UserId', id);
  }

  Future<String?> getUserId() async {
    final sharedPreference = await SharedPreferences.getInstance();
    final id = sharedPreference.getString('UserId');
    return id;
  }

  Future<void> storeUserName(String userName) async {
    final sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.setString('UserName', userName);
  }

  Future<String?> getUserName() async {
    final sharedPreference = await SharedPreferences.getInstance();
    final userName = sharedPreference.getString('UserName');
    return userName;
  }

  Future<void> storeToken(String token) async {
    final sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.setString('apiToken', token);
  }

  Future<String?> getToken() async {
    final sharedPreference = await SharedPreferences.getInstance();
    final token = sharedPreference.getString('apiToken');
    return token;
  }

  Future<bool> logOut() async {
    final sharedPreference = await SharedPreferences.getInstance();
    final removed = await sharedPreference.clear();
    return removed;
  }
}
