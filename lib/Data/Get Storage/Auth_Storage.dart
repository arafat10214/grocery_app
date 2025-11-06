import 'dart:convert';
import 'package:groceries_app/Data/Model/User_model.dart';
import 'package:logger/logger.dart';
import 'package:get_storage/get_storage.dart';

class AuthStorage {
  static final String _userTokenKey = "userTokenKey";
  static final String isLoginKey = "isLoginKey";
  static final String _userModelKey = "userModelKey";

  static String? accessToken;
  static UserModel? accessModel;

  //=========================== User Data Save ================================
  static Future saveUserData(String token, UserModel model) async {
    GetStorage store = GetStorage();
    //---------------- store in local storage -------
    await store.write(_userTokenKey, token);
    await store.write(_userModelKey, jsonEncode(model.toJson()));
    await store.write(isLoginKey, true);
    //--------------- local variable value set -------
    accessToken = token;
    accessModel = model;

    Logger logger = Logger();
    logger.i("User data save successful");
    logger.i("User token: ${store.read(_userTokenKey)}");
    logger.i("User user model : ${store.read(_userModelKey)}");
    logger.i("User token: ${store.read(isLoginKey)}");
  }

  //=========================== Get Data Save ================================
  static Future getUserData() async {
    GetStorage store = GetStorage();
    //---------------- store in local storage -------
    String? token = store.read(_userTokenKey);
    String? userModel = store.read(_userModelKey);

    if (token != null) {
      accessToken = token;
      if (userModel != null) {
        accessModel = UserModel.fromJson(jsonDecode(userModel));
      }
    }
  }

  //=================== Login status ============
  static bool isLogin() {
    GetStorage storage = GetStorage();
    return storage.read(isLoginKey)??false;
  }

  //=============== Clear user data =============
  static void clearUserData() {
    GetStorage store = GetStorage();
    store.remove(_userTokenKey);
    store.remove(_userModelKey);
    store.remove(isLoginKey);
    accessToken = null;
    accessModel = null;
  }
}
