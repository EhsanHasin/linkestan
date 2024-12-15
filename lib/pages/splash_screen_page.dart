import 'dart:async';

import 'package:flutter/material.dart';
import 'package:linkestan/pages/home_page.dart';
import '../utilities/my_constants.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/appLogo.jpg",),
              SizedBox(height: 10,),
              Text(APP_Name, style: TextStyle(fontSize: 45),),
              Text(APP_VERSION, style: TextStyle(fontSize: 20),)
            ],
          ),
        ),
      ),
    );
  }
}

