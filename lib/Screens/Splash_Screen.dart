import 'package:flutter/material.dart';
import 'package:groceries_app/Screens/Onbording.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff53B175),
    body: Column(
  children: [
    SizedBox(height: 410,),
    Center(child: GestureDetector(child: Image.asset('assets/images/pic-1.png'),
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Onbording(),));
    },
    )),
  ],
),
    );
  }
}
