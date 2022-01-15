import 'package:flutter/material.dart';

import '../widgets/login.dart';
import '../widgets/registerPage.dart';

class FirstPage extends StatelessWidget {
  void selectLogInScreen(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return LogInPage();
    }));
  }

  void selectRegisterScreen(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return MyRegisterPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(40, 250, 100, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
            )),
          ),
          Container(
            margin: EdgeInsets.all(60),
            child: Text(
              "Welcome!",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  height: 1),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/shopping-bird-16623082.jpg",
              fit: BoxFit.fill,
              height: 300,
            ),
          ), //image

          Container(
            margin: EdgeInsets.fromLTRB(30, 80, 30, 2),
            child: ElevatedButton(
              child: Text(
                "Log In",
                style: TextStyle(fontSize: 23),
              ),
              onPressed: () {
                selectLogInScreen(context);
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(52, 10, 52, 10))),
            ),
          ), //log in button

          Container(
            child: OutlinedButton(
              child: Text("Sign Up", style: TextStyle(fontSize: 20)),
              onPressed: () {
                selectRegisterScreen(context);
              },
              style: ButtonStyle(
                  //fixedSize: MaterialStateProperty.all(Size.fromWidth(150)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(50, 10, 50, 10))),
            ),
          ), //sign up button
        ],
      ),
    );
  }
}
