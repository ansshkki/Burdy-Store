import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:store/api/fetchsearchedproduct.dart';
import 'package:store/api/securestorage.dart';
import 'package:store/config/service-config.dart';
import 'package:store/models/getproductsclass.dart';
import 'package:store/widgets/showoneproduct.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var named;

  var priced;

  List listItem = ["Sports", "Technology", "Food", "Others"];

  DateTime? expirationDate;

  String time = '?';

  var id;

  bool p = false;

  var token;

  String names = 'zzzzzz', prices = '88888888', ids = '6', dates = '2100-1-1';

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

  void selectShowOneProduct(BuildContext ctx, int id) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return ShowOneProduct(
        id: id,
      );
    }));
  }

  @override
  initState() {
    //token = SharedPrefs.getToken() ;
    super.initState();
    init();
  }

  init() {
    SecureStorage storage = SecureStorage();
    storage.read().then((result) {
      setState(() {
        token = result;
        print(token + 'dddd');
      });
    });
  }

  String? valueChoosen;
  FetchSearchedData dataa = FetchSearchedData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Search Products'),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            //the enter name field

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.fromLTRB(5, 10, 10, 20),
                  child: TextField(
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
                    onChanged: (v) {
                      setState(() {
                        named = v;
                      });
                    },
                  ),
                ),
                //THE CATEGORY
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 5, 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButton(
                        icon: Icon(Icons.arrow_drop_down_circle_outlined),
                        iconSize: 35,
                        hint: Text('   Select category  '),
                        underline: SizedBox(),
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        style: TextStyle(fontSize: 20, color: Colors.black),
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
                                style: TextStyle(color: Colors.indigo[300]),
                              ),
                              value: valueItem,
                            );
                          },
                        ).toList()),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: 'price ',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.price_check,
                        color: Colors.deepOrange,
                      ),
                    ),
                    onChanged: (v) {
                      setState(() {
                        priced = v;
                      });
                    },
                  ),
                ),
                //the text to view the date

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Container(
                        padding: const EdgeInsets.only(top: 7),
                        width: MediaQuery.of(context).size.width * 0.4,
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
                      child: Text('Expiration date'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),

            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  if (named != null) {
                    names = named;
                  } else
                    names = 'zzzzzz';

                  if (priced != null) {
                    prices = priced;
                  } else
                    prices = '88888888';

                  if (id != null) {
                    ids = id;
                  } else
                    ids = '6';

                  if (time != '?') {
                    dates = time;
                  } else if (time == '?') dates = '2100-1-1';

                  p = true;
                  EasyLoading.showSuccess('');
                  print(names + prices + dates + ids);
                });
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              label: (Text(
                'search',
                style: TextStyle(color: Colors.white),
              )),
            ),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Divider(
                height: 18.0,
                thickness: 0.6,
                color: Colors.deepOrange,
              ),
            ),

            Expanded(
              child: FutureBuilder<List<GetProducts>>(
                future:
                    dataa.fetchSearchedProducts(names, prices, ids, dates, p),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Container(
                          margin: EdgeInsets.all(20),
                          height: 200,
                          child: InkWell(
                            onTap: () {
                              int id = snapshot.data![index].id!;
                              selectShowOneProduct(context, id);
                            },
                            child: Card(
                              //حط sized box واعطيه هايت مشان تطول الكارد

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 16,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                      child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      ServerConfig.domainNameServer +
                                          snapshot.data![index].imageUrl!,
                                      // Utils.getproduct[index].imageUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                                  Positioned(
                                    bottom: 16,
                                    left: 8,
                                    child: Text(
                                      snapshot.data![index].name!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //child: Text(addproduct[index].name),
                        ); //container prudacts name
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (!snapshot.hasData) {
                    return Text('no data yet');
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
