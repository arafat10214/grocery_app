import 'package:flutter/material.dart';
import 'package:groceries_app/Data/Api_service/Api_Response.dart';
import 'package:groceries_app/Data/Api_service/Api_service.dart';
import 'package:logger/logger.dart';


class SignupProvider extends ChangeNotifier {
  //--------------- logger instance create ------------
  Logger logger = Logger();

  //----------------- Password visibility off on -----------
  bool isPasswordHide = true;

  //---------------------- formKey --------------
  final signupFormKey = GlobalKey<FormState>();

  //------------------ Signup Controller ------------
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //-------------------- signup circular progress ---------------
  bool inProgressIndicator = false;

  //============================ Signup Method =======================
  Future<bool> signup(context) async {
    if (signupFormKey.currentState!.validate()) {
      await registerUser(context);
      return true;
    } else {
      return false;
    }
  }

  //====================== Register user ======================
  Future registerUser(context) async {
    inProgressIndicator = true;
    notifyListeners();
    // final url = Uri.parse("https://foodsflow.netlify.app/api/api/auth/register");
    //----------------- Request data --------
    Map<String, dynamic> requestBody = {
      "name": userNameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    };

    //---------------- await for response ----------
    final ApiResponse response = await ApiServices.postData(
      //Urls.registerUrl,
      Uri.parse("https://foodsflow.netlify.app/api/auth/register"),
      requestBody,
    );
    if (response.isSuccess && response.statusCode == 201) {
      inProgressIndicator = false;
      notifyListeners();
      logger.i(response.message);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registed successful")));
    } else {
      logger.i(response.message);
    }
  }

  //========================= Password Visibility =======
  void isPasswordVisibility() {
    isPasswordHide = !isPasswordHide;
    notifyListeners();
  }

  //==================== Dispose all field ==============
  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
