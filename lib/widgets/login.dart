import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:store/api/securestorage.dart';
import 'package:store/config/service-config.dart';
import 'package:store/config/user-information.dart';

import 'bottombar.dart';
import 'registerPage.dart';

//done
class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();

  static bool checkbox = false;
}

class _LogInPageState extends State<LogInPage> {
  late SecureStorage _check;

  test() async {
    _check = SecureStorage();
    await checkToken();
  }

  @override
  initState() {
    test();
    super.initState();
  }

  Future<void> checkToken() async {
    String? token = await _check.readToken('token');
    print('tpken 000-=' + token.toString());
    if (token != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return BottomBar();
      }));
    }
  }

  bool passwordVisible = true;

  UserInformation userInformation = UserInformation();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

//التنقل الى صفحة تسجيل دخول login
  void selectRegisterScreen(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return MyRegisterPage();
    }));
  }

//التنقل الى الصفحة الرآيسية bottombar
  void bottomBarScreen(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return BottomBar();
        },
      ),
    );
  }

//توابع ومتحولات الربط
  var message, token;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.signin);

  Future<bool> loginAuth() async {
    var response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        //'name':'${user.name}',  نفس يلي تحتا
        'email': email.text,
        'password': password.text,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      token = jsonResponse['token'];
      print(token);
      SecureStorage storage = SecureStorage();
      await storage.save(token);
      print('done');

      return true;
    } else if (response.statusCode == 422) {
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse['message'];
      return false;
    } else if (response.statusCode == 401) {
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse['message'];
      return false;
    } else {
      return false;
    }
  }

  void checkUser() async {
    EasyLoading.show(status: 'loading..', dismissOnTap: true);
    if (await loginAuth()) {
      EasyLoading.showSuccess('your account logged in successfully',
          duration: Duration(milliseconds: 300));
      bottomBarScreen(context);
    } else {
      EasyLoading.showError(message); //put message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Container(
                child: Text('Welcome to the Burdy store',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.deepOrange, fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Container(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                    "assets/birdbag.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(60, 0, 60, 2),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 8),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter email";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(60, 0, 60, 2),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 8),
                        borderRadius: BorderRadius.circular(8)),
                    hintText: "Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.deepOrange,
                        )),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  controller: password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter password";
                    }
                    return null;
                  },
                  obscureText: passwordVisible,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(30, 50, 50, 2),
                child: ElevatedButton(
                  child: const Text(
                    "Log In",
                    style: TextStyle(fontSize: 23),
                  ),
                  onPressed: () {
                    checkUser();
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(52, 15, 52, 15),
                    ),
                    shadowColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepOrange),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //margin: EdgeInsets.fromLTRB(30, 0, 30, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have a Burdy account?    "),
                    TextButton(
                      child: Text("Register",
                          style: TextStyle(
                              color: Colors.deepOrange, fontSize: 17.5)),
                      onPressed: () {
                        selectRegisterScreen(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
