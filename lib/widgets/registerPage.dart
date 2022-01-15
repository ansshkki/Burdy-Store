import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:store/api/securestorage.dart';
import 'package:store/config/service-config.dart';
import 'package:store/widgets/bottombar.dart';

import 'login.dart';

//done
class MyRegisterPage extends StatefulWidget {
  @override
  _MyRegisterPageState createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  TextEditingController name = new TextEditingController();

  TextEditingController email = new TextEditingController();

  TextEditingController password = new TextEditingController();

  TextEditingController number = new TextEditingController();

  TextEditingController address = new TextEditingController();

  bool passwordVisible = true;

  //تابع التنقل للضفحة الرآيسية
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
  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.register);

  Future<bool> registerAuth() async {
    var response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        //'name':'${user.name}',  نفس يلي تحتا
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'phone': number.text,
        'address': address.text,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      token = jsonResponse['token'];
      SecureStorage storage = SecureStorage();
      await storage.save(token);
      print('done');
      return true;
    } else if (response.statusCode == 422) {
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse['message'];
      return false;
    } else {
      return false;
    }
  }

  void addNewUserData() async {
    EasyLoading.show(status: 'loading..', dismissOnTap: true);
    if (await registerAuth()) {
      EasyLoading.showSuccess('your account registered successfully');
      bottomBarScreen(context);
    } else {
      EasyLoading.showError('error here');
    }
  }

  void selectLogInScreen(BuildContext ctx) {
    Navigator.of(ctx).pop(MaterialPageRoute(builder: (_) {
      return LogInPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // color: Color.fromARGB(40, 250, 100, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 29,
                ),

                Image.asset(
                  "assets/freebirds_full.jpg",
                  fit: BoxFit.fill,
                ),

                SizedBox(
                  height: 10,
                ),

                Text(
                  'Hurry up and GO make a Burdy account!',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),

                SizedBox(
                  height: 40,
                ),

                //the enter name field
                Container(
                  padding: EdgeInsets.all(4),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    maxLength: 15,
                    decoration: InputDecoration(
                      hintText: 'Name: ',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.deepOrange,
                      ),
                    ),
                    controller: name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter name";
                      }
                      return null;
                    },
                  ),
                ),

                //the enter email field

                Container(
                  padding: EdgeInsets.all(4),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    maxLength: 15,
                    decoration: InputDecoration(
                      hintText: 'Email: ',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.deepOrange,
                      ),
                    ),
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter email";
                      }
                      return null;
                    },
                  ),
                ),

                //the enter password field

                Container(
                  padding: EdgeInsets.all(4),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    maxLength: 15,
                    decoration: InputDecoration(
                        hintText: 'Password: ',
                        border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.vpn_key_outlined,
                          color: Colors.deepOrange,
                        ),
                        suffixIcon: IconButton(
                          color: Colors.grey,
                          icon: Icon(passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility_rounded),
                          onPressed: () {
                            setState(() => passwordVisible = !passwordVisible);
                          },
                        )),
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

                //the enter number field

                Container(
                  padding: EdgeInsets.all(4),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    maxLength: 15,
                    decoration: InputDecoration(
                      hintText: 'Number: ',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        color: Colors.deepOrange,
                      ),
                    ),
                    controller: number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter number";
                      }
                      return null;
                    },
                  ),
                ),

                // the enter adress field
                Container(
                  padding: EdgeInsets.all(4),
                  child: TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    maxLength: 15,
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: 'Address: ',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.location_city,
                        color: Colors.deepOrange,
                      ),
                    ),
                    controller: address,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter address";
                      }
                      return null;
                    },
                  ),
                ),

                ///the button

                ElevatedButton(
                  onPressed: () {
                    addNewUserData();
                  },
                  child: Icon(
                    Icons.add,
                  ),
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepOrange),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                TextButton(
                  onPressed: () {
                    selectLogInScreen(context);
                  },
                  child: Text(
                    'Already have an account !',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 17.5),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ].toList(),
            ),
          ),
        ),
      ),
    );
  }
}
