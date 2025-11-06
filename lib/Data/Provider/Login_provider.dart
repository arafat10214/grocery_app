import 'package:flutter/material.dart';
import 'package:groceries_app/Data/Api_service/Api_Response.dart';
import 'package:groceries_app/Data/Api_service/Api_service.dart';
import 'package:groceries_app/Data/Api_service/Urls.dart';
import 'package:groceries_app/Data/Get%20Storage/Auth_Storage.dart';
import 'package:groceries_app/Data/Model/User_model.dart';
import 'package:logger/logger.dart';

class LoginProvider extends ChangeNotifier {
  final Logger logger = Logger();

  //----------------- UI state -----------------
  bool isPasswordHide = true;
  bool inProgressIndicator = false;
  bool isLoginSuccess = false;

  //---------------------- formKey --------------
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  //------------------ Controllers ------------
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //============================ Login Method =======================
  Future<bool> login() async {
    if (loginFormKey.currentState!.validate()) {
      return await loginUser();
    } else {
      logger.w("Form validation failed!");
      return false;
    }
  }

  //============================ Login User ==========================
  Future<bool> loginUser() async {
    inProgressIndicator = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    };

    logger.i("Sending Login Request: $requestBody");

    ApiResponse response = await ApiServices.postData(
      Urls.loginUrl,
      requestBody,
    );

    inProgressIndicator = false;
    notifyListeners();
    //================= Response Success ==================
    if (response.isSuccess && (response.statusCode == 200 || response.statusCode == 201)) {
      try {
        final token = response.responseBody["data"]["token"];
        final userJson = response.responseBody["data"]["user"];
        if (token == null || userJson == null) {
          logger.e("Invalid API Response Format");
          return false;
        }

        UserModel model = UserModel.fromJson(userJson);

        //----------- Local Storage e Save ----------
        await AuthStorage.saveUserData(token, model);
        logger.i("Login Successful!");
        logger.i("Token: $token");
        logger.i("User: ${model.toJson()}");

        //------------- Success Flag --------------
        isLoginSuccess = true;
        notifyListeners();

        clearField();
        return true;
      } catch (e) {
        logger.e("Error parsing response: $e");
        return false;
      }
    }

    //================= Response Failed ==================
    else {
      logger.w(" Login Failed. Message: ${response.message}");
      isLoginSuccess = false;
      notifyListeners();
      return false;
    }
  }

  //========================= Password Visibility ====================
  void isPasswordVisibility() {
    isPasswordHide = !isPasswordHide;
    notifyListeners();
  }

  //==================== Clear all field ===========================
  void clearField() {
    emailController.clear();
    passwordController.clear();
  }

  //==================== Dispose all field ==========================
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
