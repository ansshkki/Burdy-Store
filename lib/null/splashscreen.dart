import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/login.dart';

//done
class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    await Future.delayed(Duration(milliseconds: 4000));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
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
          backgroundColor: Colors.deepOrange.shade100),
    );
  }
}
