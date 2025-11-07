import 'package:flutter/material.dart';
import 'package:groceries_app/Data/Api_service/Api_Response.dart';
import 'package:groceries_app/Data/Api_service/Api_service.dart';
import 'package:groceries_app/Data/Api_service/Urls.dart';
import 'package:groceries_app/Data/Get%20Storage/Auth_Storage.dart';
import 'package:groceries_app/Data/Model/User_model.dart';
import 'package:logger/logger.dart';

class LoginProvider extends ChangeNotifier {
  Logger logger = Logger();



  //----------------- Password visibility off on -----------
  bool isPasswordHide = true;

  //---------------------- formKey --------------
  final loginFormKey = GlobalKey<FormState>();

  //------------------ Login Controller ------------
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool inProgressIndicator = false;

  bool isLoginSuccess = false;

  //============================ Login User ==========================
  Future loginUser() async {
    inProgressIndicator = true;
    isLoginSuccess = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      "email":emailController.text.trim(),
      "password":passwordController.text.trim(),
    };

    ApiResponse response = await ApiServices.postData(
      Urls.loginUrl,
      requestBody,
    );

    inProgressIndicator = false;
    notifyListeners();

    if (response.isSuccess && (response.statusCode == 201 || response.statusCode == 200)) {

      final token = response.responseBody["data"]["token"];
      //--------- user model e data save -------
      UserModel model = UserModel.fromJson(
        response.responseBody["data"],
      );

      //----------- Get storage e data save --------------
      await AuthStorage.saveUserData(token, model);
      AuthStorage.isLogin();
      isLoginSuccess = true;
      notifyListeners();
      //------------ Clear all field -----------
      clearField();
      return true;
    } else {
      logger.i(response.message);
      isLoginSuccess =false;
      notifyListeners();
      return false;
    }
  }

  //========================= Password Visibility ====================
  void isPasswordVisibility() {
    isPasswordHide = !isPasswordHide;
    notifyListeners();
  }
  //==================== clear all field ===========================
  void clearField(){
    emailController.clear();
    passwordController.clear();
  }


  //==================== Dispose all field ===========================
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}