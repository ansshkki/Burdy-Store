import 'package:flutter/material.dart';
import 'package:store/api/fetchProd.dart';
import 'package:store/config/service-config.dart';
import 'package:store/models/oneproductclass.dart';
import 'package:store/widgets/bottombar.dart';

class ShowOneProduct extends StatelessWidget {
  //to fetch one product deatils.
  FetchProd _fetchProd = FetchProd();
  late OneProduct deta;
  var id;

  // var snap;
  ShowOneProduct({required this.id
      //    required this.index,
      //    required this.snap,
      });

  void selectBottomBar(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
      return BottomBar();
    }));
  }

  String t = 'Price:';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        leading: IconButton(
            onPressed: () {
              return selectBottomBar(context);
            },
            icon: Icon(
              Icons.arrow_back,
            )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: FutureBuilder<OneProduct>(
            future: _fetchProd.fetchProd(id),
            builder: (context, snapchot) {
              if (snapchot.hasData) {
                return Column(
                  children: [
                    ClipRRect(
                      // borderRadius: BorderRadius.vertical( ),
                      child: Image.network(
                        ServerConfig.domainNameServer +
                            snapchot.data!.imageUrl!,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ("Name: ") + snapchot.data!.name!,
                            style: TextStyle(
                                fontSize: 20, color: Colors.deepOrange),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapchot.data!.price! ==
                                    snapchot.data!.currentPrice!
                                ? t + snapchot.data!.price!.toString()
                                : 'Current Price:' +
                                    snapchot.data!.currentPrice!.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.deepOrange,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Available Amount: " +
                            snapchot.data!.quantity!.toString(),
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Contact Number: " + snapchot.data!.user!.phone!,
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapchot.data!.currentPrice! != snapchot.data!.price!
                            ? 'Sale: ' +
                                snapchot.data!.current_sale!.toString() +
                                '%'
                            : 'Current Price: ' +
                                snapchot.data!.price.toString(),
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapchot.data!.currentPrice! != snapchot.data!.price!
                            ? 'Old Price: ' + snapchot.data!.price!.toString()
                            : 'Wait For Discounts!',
                        style: TextStyle(fontSize: 19, color: Colors.red),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Expiration Date: " +
                            snapchot.data!.expirationDate!.toString(),
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.deepOrange,
                      ),
                      height: 200,
                      width: 300,
                      child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Thank's for watching Product!",
                                  textScaleFactor: 1.3,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 40,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapchot.hasError) {
                print("this is test in show one product");
                print(id);
                return Text("Sorry there is an error");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
