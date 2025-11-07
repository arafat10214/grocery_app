import 'package:flutter/material.dart';
import 'package:groceries_app/Data/Provider/Login_provider.dart';
import 'package:groceries_app/Screens/Select_Location.dart';
import 'package:groceries_app/Screens/SignUp_Screen.dart';
import 'package:groceries_app/Validator/Input_validators.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Consumer<LoginProvider>(
            builder: (context, login, child) {
              return Form(
                key: login.loginFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    Center(child: Image.asset('assets/images/logo.png')),
                    SizedBox(height: 100),
                    Text(
                      'Loging',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Enter your emails and password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff7C7C7C),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff7C7C7C),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: login.emailController,
                      validator: InputValidators.emailValidator,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff7C7C7C),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: login.passwordController,
                      validator: InputValidators.passwordValidator,
                      textInputAction: TextInputAction.done,
                      obscureText: login.isPasswordHide,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: login.isPasswordVisibility,
                          child: Icon(
                            login.isPasswordHide
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async{
                          if(login.loginFormKey.currentState!.validate()){
                            await login.loginUser();
                            // login.isLoginSuccess =true;
                          if(login.isLoginSuccess =true){
                          ////////// ----------Snackbar --------------------//////////
                          ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text("Login successful")),
                          );
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectLocation()));
                          }else{
                             ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Invalid email or password",
                                      ),
                                    ),
                                  );
                            }

                          }
                        }, 
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff53B175),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(16),
                          ),
                        ),
                      ),
                      ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Image.asset('assets/images/google.png'),
                            SizedBox(width: 70),
                            Text(
                              'Continue with Google',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff5383EC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Singup',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff53B175),
                            ),
                          ),
                        ),
                      ],
                    ),
              ])
              );
            },
        )
        )
      )
    );
}
}