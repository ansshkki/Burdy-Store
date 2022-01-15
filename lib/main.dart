import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'widgets/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Burdy',
      home: AnimatedSplashScreen(
          duration: 1000,
          splashIconSize: 900,
          splash: Container(
            height: 600,
            width: 350,
            child: Image.asset(
              "assets/bird-in-splash-screen.png",
            ),
          ),
          nextScreen: LogInPage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.deepOrange.shade400),
      builder: EasyLoading.init(),
    );
  }
}
