import 'package:flutter/material.dart';
import 'package:groceries_app/Data/Provider/Login_provider.dart';

import 'package:groceries_app/Screens/Splash_Screen.dart';
import 'package:provider/provider.dart';
import 'Data/Provider/Signup_Provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
