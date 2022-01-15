import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:store/api/fetchsearchedproduct.dart';
import 'package:store/api/reaction.dart';
import 'package:store/api/securestorage.dart';
import 'package:store/config/service-config.dart';
import 'package:store/models/getproductsclass.dart';
import 'package:store/widgets/comments.dart';

import 'login.dart';
import 'showoneproduct.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //List<AddProduct> addproduct = Utils.getMockedaddproduct();
  FetchSearchedData _fetchData = FetchSearchedData();
  Reaction reaction = Reaction();
  SecureStorage storage = SecureStorage();

  String? token;

  String id = '0';

  bool like = false;

  @override
  initState() {
    //token = SharedPrefs.getToken() ;
    super.initState();
    init();
  }

  init() {
    storage.read().then((result) {
      setState(() {
        token = result;
        print(token);
      });
    });
  }

  void selectLogOut(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
      return LogInPage();
    }));
  }

  void selectComment(BuildContext ctx, int id) {
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
      return Comment(id: id);
    }));
  }

  void selectShowOneProduct(BuildContext ctx, int id) {
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
      return ShowOneProduct(
        id: id,
        //  snap: snap,
      );
    }));
  }

  void logout() async {
    EasyLoading.show(status: 'loading..', dismissOnTap: true);
    if (await _fetchData.logoutAuth()) {
      EasyLoading.showSuccess(
        'you logged out',
      );
      storage.delete();
      return selectLogOut(context);
    } else {
      EasyLoading.showError(''); //put message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 8, 8, 8),
            child: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.deepOrange,
                          ),
                          Text("Log Out"),
                        ],
                      ),
                      onTap: () {
                        logout();
                      },
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: Colors.deepOrange,
                          ),
                          Text("About Us"),
                        ],
                      ),
                      onTap: () {},
                    )
                  ];
                },
                child: Icon(Icons.more_vert)),
          ),
        ],
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        id == '0' ? Colors.white : Colors.deepOrange)),
                onPressed: () {
                  setState(() {
                    id = '0';
                  });
                },
                icon: Icon(
                  Icons.shopping_bag,
                  color: id == '0' ? Colors.deepOrange : Colors.white,
                ),
                label: Text(
                  'All',
                  style: TextStyle(
                      color: id == '0' ? Colors.deepOrange : Colors.white),
                ),
              ),
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
                  Icons.person,
                  color: id == '1' ? Colors.deepOrange : Colors.white,
                ),
                label: Text('Name',
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
                  Icons.price_change,
                  color: id == '2' ? Colors.deepOrange : Colors.white,
                ),
                label: Text('Price',
                    style: TextStyle(
                        color: id == '2' ? Colors.deepOrange : Colors.white)),
              ),
            ],
          ),
        ),
        // c\  Padding(
        //     padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
        //     child: PopupMenuButton(
        //         itemBuilder: (context) {
        //           return [
        //             PopupMenuItem(
        //               child: Row(
        //                 children: [
        //                   Icon(
        //                     Icons.logout,
        //                     color: Colors.deepOrange,
        //                   ),
        //                   Text("Log Out"),
        //                 ],
        //               ),
        //               onTap: () {
        //                 logout();
        //               },
        //             ),
        //             PopupMenuItem(
        //               child: Row(
        //                 children: [
        //                   Icon(
        //                     Icons.info,
        //                     color: Colors.deepOrange,
        //                   ),
        //                   Text("About Us"),
        //                 ],
        //               ),
        //               onTap: () {},
        //             )
        //           ];
        //         },
        //         child: Icon(Icons.more_vert)),
        //   ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            /*Container(child: Text(token ?? "sami")
                //Text(prefs!.getString("token")!),
                ),*/
            Expanded(
              child: FutureBuilder<List<GetProducts>>(
                future: _fetchData.sortProducts(id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(20),
                              height: 250,
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                elevation: 16,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                        child: Container(
                                      // margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                                      child: InkWell(
                                        onTap: () {
                                          int id = snapshot.data![index].id!;
                                          print("this is test in home");
                                          print(id);

                                          selectShowOneProduct(context, id);
                                        },
                                        onDoubleTap: () {
                                          setState(() {
                                            like = !like;
                                          });
                                          reaction.likeReaction(
                                              snapshot.data![index].id!);
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            ServerConfig.domainNameServer +
                                                snapshot.data![index].imageUrl!,
                                            //   Utils.getproduct[index].imageUrl!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )),
                                    Positioned(
                                      bottom: 50,
                                      left: 8,
                                      child: Text(
                                        snapshot.data![index].name!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 8,
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      bottom: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1),
                                              child: Row(children: [
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      like = !like;
                                                    });
                                                    reaction.likeReaction(
                                                        snapshot
                                                            .data![index].id!);
                                                  },
                                                  icon: Icon(
                                                    //Icons.favorite
                                                    snapshot.data![index]
                                                                .isLiked! ==
                                                            1
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: Colors.deepOrange,
                                                  ),
                                                  iconSize: 25.0,
                                                ),
                                                Text(
                                                  //setState((){
                                                  snapshot
                                                      .data![index].likesCount!
                                                      .toString(),
                                                  //} ),

                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ]),
                                            ),
                                            Center(
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      var commentId = snapshot
                                                          .data![index].id!;
                                                      return selectComment(
                                                          ctx, commentId);
                                                    },
                                                    icon: Icon(Icons
                                                        .chat_bubble_outline),
                                                    iconSize: 25.0,
                                                    color: Colors.deepOrange,
                                                  ),
                                                  Text(
                                                    snapshot.data![index]
                                                        .commentsCount!
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .visibility_outlined,
                                                        size: 25.0,
                                                        color:
                                                            Colors.deepOrange,
                                                      ),
                                                      Text(
                                                        "   " +
                                                            snapshot
                                                                .data![index]
                                                                .views!
                                                                .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Sorry there is an error");
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
