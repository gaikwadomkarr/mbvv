import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static String UserIdKey = "userid";
  static String UserLoggedInKey = "loggedin";
  static String UserTokenKey = "USERTOKEN";
  static String userName = "USERNAME";

//  static Prefrences _instance = new Prefrences.internal();
//  static Prefrences getInstance() {
//    return _instance;
//  }
//  Prefrences.internal();

  /**
   * User Login Prefrences
   */
  static void saveUserLoggedIn(bool isUserLoggedIn) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setBool(UserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> getUserLoggedIn() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(UserLoggedInKey) ?? false;
  }

  /**
   * User token
   */
  static void saveToken(String token) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(UserTokenKey, token);
  }

  static Future<String> getToken() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(UserTokenKey) ?? '';
  }

  /**
   * User id
   */
  static void saveUserId(int userId) async {
    var storage = await GetStorage();
    return await storage.write(UserIdKey, userId);
  }

  static Future<int?> getUserId() async {
    var storage = await GetStorage();
    return await storage.read(UserIdKey);
  }

  /**
   * User role
   */

  static void saveUserName(String role) async {
    var storage = GetStorage();
    return await storage.write(userName, role);
  }

  static Future<String> getUserName() async {
    var storage = GetStorage();
    return await storage.read(userName) ?? '';
  }

  static Future<GetStorage> getStorage() async {
    var storage = GetStorage();
    return storage;
  }
}
