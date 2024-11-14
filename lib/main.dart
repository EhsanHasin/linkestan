import 'package:flutter/material.dart';
import 'package:linkestan/pages/setting_page.dart';
import 'package:linkestan/pages/splash_screen_page.dart';
import 'utilities/my_constants.dart';
import 'pages/home_page.dart';
void main() => runApp(
    MaterialApp(
      title: APP_Name,
      theme: ThemeData(
        primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.lightGreenAccent
      ),
      initialRoute: ROUTE_SPLASH_SCREEN_PAGE,
      routes: {
            ROUTE_SPLASH_SCREEN_PAGE : (context)=> SplashScreen(),
            ROUTE_HOME_PAGE : (context)=> HomePage(),
            ROUTE_SETTING_PAGE : (context)=> SettingPage(),
      },
      debugShowCheckedModeBanner: false,
    )
);

