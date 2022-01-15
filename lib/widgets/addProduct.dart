import 'dart:async';
import 'dart:convert';
import 'dart:io' as used;

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:store/api/securestorage.dart';
import 'package:store/config/service-config.dart';
import 'package:store/models/addproductclass.dart';
import 'package:store/widgets/bottombar.dart';

class MyAddNewProductPage extends StatefulWidget {
  @override
  _MyAddNewProductPageState createState() => _MyAddNewProductPageState();
}

class _MyAddNewProductPageState extends State<MyAddNewProductPage> {
  TextEditingController name = new TextEditingController();

  TextEditingController category = new TextEditingController();

  TextEditingController availableAmount = new TextEditingController();

  TextEditingController price = new TextEditingController();

  void bottomBarScreen(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return BottomBar();
        },
      ),
    );
  }

  used.File? imageController;

  final picker = ImagePicker();

  Future takePhotoFromGallery() async {
    final selectedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      if (selectedImage != null) {
        imageController = used.File(selectedImage.path);
      }
    });
  }

  Future takePhotoFromCamera() async {
    final selectedImage = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (selectedImage != null) {
        imageController = used.File(selectedImage.path);
      }
    });
  }

  List listItem = ["Sports", "Technology", "Food", "Others"];

  void editCategory() {
    if (valueChoosen == "Sports") {
      id = '1';
    } else if (valueChoosen == "Technology") {
      id = '2';
    } else if (valueChoosen == "Food") {
      id = '3';
    } else {
      id = '4';
    }
  }

  String? valueChoosen;

  DateTime? expirationDate, expirationDate1, expirationDate2, expirationDate3;

  String time = "?", time1 = "?", time2 = "?", time3 = "?";

  double sale1 = 0, sale2 = 0, sale3 = 0;

  late String periodsString;

  //final List<AddProduct> _listOfProducts = Utils.getproduct;

  late AddProduct prod;
  String id = '4';

  //to send periods in json
  void sendAsJson() {
    final periods = [
      {
        'date': time3 == '?'
            ? time3 = DateFormat('yyyy-MM-dd').format(expirationDate!)
            : time3,
        'sale': sale3.toString()
      },
      {
        'date': time2 == '?'
            ? time2 = DateFormat('yyyy-MM-dd').format(expirationDate!)
            : time2,
        'sale': sale2.toString()
      },
      {
        'date': time1 == '?'
            ? time1 = DateFormat('yyyy-MM-dd').format(expirationDate!)
            : time1,
        'sale': sale1.toString()
      },
    ];
    setState(() {
      periodsString = json.encode(periods);
      print(periodsString);
      print('done formatting');
    });
  }

  var message, token;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.allproduct);

  //sending to back
  SecureStorage storage = SecureStorage();

  Future<bool> newProductCheck() async {
    var token = await storage.read();
    var request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageController!.path,
      ),
    );
    request.headers.addAll(
        {'Accept': 'Application/json', 'Authorization': 'Bearer $token'});
    request.fields['name'] = name.text;
    request.fields['expiration_date'] = time;
    request.fields['price'] = price.text;
    request.fields['quantity'] = availableAmount.text;
    request.fields['category_id'] = id;
    request.fields['periods'] = periodsString;
    print(name.text +
        time +
        price.text +
        availableAmount.text +
        id +
        periodsString);
    var response = await request.send();
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 422) {
      EasyLoading.showError('invalid Credentials');
      return false;
    } else {
      print(response.statusCode);
      print(response.isRedirect);
      print(response.reasonPhrase);
      return false;
    }
  }

  void sendProduct() async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    if (await newProductCheck()) {
      EasyLoading.showSuccess('your product submitted successfully');
      bottomBarScreen(context);
    } else {
      print('error ');
      print('/n');
      EasyLoading.showError('message'); //put message
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 29,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/birdholdingbag.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    'put your product info you want to sell!'.toUpperCase(),
                    style: TextStyle(color: Colors.red[600], fontSize: 15),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  //the enter name field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: EdgeInsets.fromLTRB(5, 10, 10, 20),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          decoration: InputDecoration(
                            hintText: 'Name ',
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
                      //THE CATEGORY
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 5, 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.deepOrange, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButton(
                              icon: Icon(Icons.arrow_drop_down_circle_outlined),
                              iconSize: 35,
                              hint: Text('   Select category  '),
                              underline: SizedBox(),
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              value: valueChoosen,
                              onChanged: (newValue) {
                                setState(() {
                                  valueChoosen = newValue as String?;
                                  //we send valueChoosen
                                });
                                editCategory();
                                print(id);
                              },
                              items: listItem.map(
                                (valueItem) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      '   ' + valueItem,
                                      style:
                                          TextStyle(color: Colors.indigo[300]),
                                    ),
                                    value: valueItem,
                                  );
                                },
                              ).toList()),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //enter image

                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.infinity * 0.9,
                      height: 300,
                      child: Center(
                        child: imageController == null
                            ? Text(
                                ' No image is picked ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              )
                            : Image.file(
                                used.File(imageController!.path),
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton.icon(
                        onPressed: () {
                          takePhotoFromCamera();
                        },
                        icon: Icon(Icons.camera),
                        label: Text('Camera'),
                      ),
                      ElevatedButton.icon(
                          onPressed: () {
                            takePhotoFromGallery();
                          },
                          icon: Icon(Icons.image),
                          label: Text('Gallery'))
                    ],
                  ),

                  SizedBox(
                    height: 40,
                  ),

                  //the text to view the date

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Container(
                          padding: const EdgeInsets.only(top: 7),
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.deepOrange, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                time,
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      //the Expiry date

                      ElevatedButton(
                        onPressed: () async {
                          expirationDate = await showDatePicker(
                            context: context,
                            initialDate: expirationDate == null
                                ? DateTime.now()
                                : expirationDate!,
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2030),
                          );

                          setState(
                            () {
                              time = DateFormat('yyyy-MM-dd')
                                  .format(expirationDate!);
                            },
                          );
                        },
                        child: Text(' Expiration Date'),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  //THE availaBLE AMOUNT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          decoration: InputDecoration(
                            hintText: 'Amount',
                            border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.deepOrange,
                            ),
                          ),
                          controller: availableAmount,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter available amount and expiration date";
                            } else if (time == "?") {
                              return "please enter expiration date ";
                            }
                            return null;
                          },
                        ),
                      ),
                      //the price
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          decoration: InputDecoration(
                            hintText: 'Price: ',
                            border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.price_check_outlined,
                              color: Colors.deepOrange,
                            ),
                          ),
                          controller: price,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter price";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  //the sales&dates field
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      'sales & dates: '.toUpperCase(),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //first sale slider
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Slider(
                            divisions: 100,
                            label: '%' + sale1.toString(),
                            value: sale1,
                            min: 0,
                            max: 99,
                            onChanged: (newPrice) {
                              setState(() {
                                sale1 = newPrice.round().toDouble();
                                print(sale1);
                              });
                            }),
                      ),
                      //column to pick date and view it
                      Column(
                        children: [
                          //text to view the date
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Container(
                              padding: const EdgeInsets.only(top: 7),
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.deepOrange, width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              child: SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    time1,
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          //date picker 1
                          ElevatedButton(
                            onPressed: () async {
                              expirationDate1 = await showDatePicker(
                                context: context,
                                initialDate: expirationDate1 == null
                                    ? DateTime.now()
                                    : expirationDate1!,
                                firstDate: DateTime.now(),
                                lastDate: expirationDate!,
                              );

                              setState(
                                () {
                                  time1 = DateFormat("yyyy-MM-dd")
                                      .format(expirationDate1!);
                                },
                              );
                            },
                            child: Text('1st sale date'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //slider 2 for second sale
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Slider(
                            label: '%' + sale2.toString(),
                            divisions: 100,
                            autofocus: true,
                            value: sale2,
                            min: 0,
                            max: 99,
                            onChanged: (newPrice) {
                              setState(() {
                                if (newPrice.round().toDouble() > sale1) {
                                  sale2 = newPrice.round().toDouble();
                                } else
                                  sale2 = sale1;
                              });
                            }),
                      ),
                      //column to show the date
                      Column(
                        children: [
                          //text to view the date
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Container(
                              padding: const EdgeInsets.only(top: 7),
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.deepOrange, width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              child: SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    time2,
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          // date picker button2
                          ElevatedButton(
                            onPressed: () async {
                              expirationDate2 = await showDatePicker(
                                context: context,
                                initialDate: expirationDate2 == null
                                    ? expirationDate1!
                                    : expirationDate2!,
                                firstDate: expirationDate1!,
                                lastDate: expirationDate!,
                              );

                              setState(
                                () {
                                  time2 = DateFormat("yyyy-MM-dd")
                                      .format(expirationDate2!);
                                },
                              );
                            },
                            child: Text('2nd sale date'),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //slider for third sale
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Slider(
                            label: '%' + sale3.toString(),
                            divisions: 100,
                            value: sale3,
                            min: 0,
                            max: 99,
                            onChanged: (newPrice) {
                              setState(() {
                                if (newPrice.round().toDouble() > sale2) {
                                  sale3 = newPrice.round().toDouble();
                                } else
                                  sale3 = sale2;

                                print(sale3);
                              });
                            }),
                      ),

                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Container(
                              padding: const EdgeInsets.only(top: 7),
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.deepOrange, width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              child: SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    time3,
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          //date pickerr 3
                          ElevatedButton(
                            onPressed: () async {
                              expirationDate3 = await showDatePicker(
                                context: context,
                                initialDate: expirationDate3 == null
                                    ? expirationDate2!
                                    : expirationDate3!,
                                firstDate: expirationDate2!,
                                lastDate: expirationDate!,
                              );

                              setState(
                                () {
                                  time3 = DateFormat("yyyy-MM-dd")
                                      .format(expirationDate3!);
                                },
                              );
                            },
                            child: Text('3rd sale date'),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 40,
                  ),

                  /// the add button
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          sendAsJson();
                          //   _addNewProduct();
                          sendProduct();
                        });
                      }
                    },
                    child: Icon(
                      Icons.add,
                    ),
                    style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all(Colors.black),
                      //  shape: MaterialStateProperty.all(RoundedRectangleBorder(  )),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepOrange),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ].toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
