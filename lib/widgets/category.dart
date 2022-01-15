import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:store/api/fetchsearchedproduct.dart';
import 'package:store/api/securestorage.dart';
import 'package:store/config/service-config.dart';
import 'package:store/models/getproductsclass.dart';
import 'package:store/widgets/showoneproduct.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  void selectShowOneProduct(BuildContext ctx, int id) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return ShowOneProduct(
        id: id,
      );
    }));
  }

  bool api = false;

  @override
  initState() {
    //token = SharedPrefs.getToken() ;
    super.initState();
    init();
  }

  var token;

  init() {
    SecureStorage storage = SecureStorage();
    storage.read().then((result) {
      setState(() {
        token = result;
        print(token + 'hhhhhhh');
      });
    });
  }

  String id = '1';
  FetchSearchedData fetchData = FetchSearchedData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        id == '1' ? Colors.white : Colors.deepOrange)),
                onPressed: () {
                  setState(() {
                    id = '1';
                  });
                },
                icon: Icon(
                  Icons.sports,
                  color: id == '1' ? Colors.deepOrange : Colors.white,
                ),
                label: Text('Sports',
                    style: TextStyle(
                        color: id == '1' ? Colors.deepOrange : Colors.white)),
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        id == '2' ? Colors.white : Colors.deepOrange)),
                onPressed: () {
                  setState(() {
                    id = '2';
                  });
                },
                icon: Icon(
                  Icons.devices,
                  color: id == '2' ? Colors.deepOrange : Colors.white,
                ),
                label: Text('Technology',
                    style: TextStyle(
                        color: id == '2' ? Colors.deepOrange : Colors.white)),
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        id == '3' ? Colors.white : Colors.deepOrange)),
                onPressed: () {
                  setState(() {
                    id = '3';
                  });
                },
                icon: Icon(
                  Icons.food_bank,
                  color: id == '3' ? Colors.deepOrange : Colors.white,
                ),
                label: Text(
                  'Food',
                  style: TextStyle(
                      color: id == '3' ? Colors.deepOrange : Colors.white),
                ),
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        id == '4' ? Colors.white : Colors.deepOrange)),
                onPressed: () {
                  setState(() {
                    id = '4';
                  });
                },
                icon: Icon(
                  Icons.shopping_bag,
                  color: id == '4' ? Colors.deepOrange : Colors.white,
                ),
                label: Text(
                  'Others',
                  style: TextStyle(
                      color: id == '4' ? Colors.deepOrange : Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<GetProducts>>(
              future: fetchData.fetchProducts(id),
              builder: (context, snapshot) {
                EasyLoading.show(
                  status: 'wait a second',
                );
                if (snapshot.hasData) {
                  EasyLoading.showSuccess('');
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Container(
                        margin: EdgeInsets.all(20),
                        height: 200,
                        child: InkWell(
                          onTap: () {
                            int id = snapshot.data![index].id!;
                            // بدي انقل هل حكي لصفحة جديدة
                            selectShowOneProduct(context, id);
                          },
                          child: Card(
                            //حط sized box واعطيه هايت مشان تطول الكارد
                            //    margin: EdgeInsets.only(bottom: 50),
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
    );
  }
}
