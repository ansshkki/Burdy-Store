import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/api/fetchData.dart';
import 'package:store/api/reaction.dart';
import 'package:store/config/service-config.dart';
import 'package:store/models/oneproductclass.dart';
import 'package:store/widgets/edit.dart';
import 'package:store/widgets/showoneproduct.dart';
//import 'package:store/widgets/editProduct.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FetchData _fetchProfile = FetchData();
  Reaction reaction = Reaction();
  List<OneProduct> profile = [];

  void selectShowOneProduct(BuildContext ctx, int id) {
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
      return ShowOneProduct(
        id: id,
        //  snap: snap,
      );
    }));
  }

  @override
  initState() {
    super.initState();
    fetchProfile();
  }

  fetchProfile() async {
    profile = await _fetchProfile.fetchProfile();

    setState(() {
      profile = profile;
    });
  }

  void selectEditPage(BuildContext ctx, int id) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Edit(id: id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrange,
        elevation: 0.0,
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),

            CircleAvatar(
              backgroundColor: Colors.white,
              //backgroundImage:
              radius: 56,
              backgroundImage: AssetImage(
                "assets/bird-app-logo.png",
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              //name
              'Burdy Account',
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              //email
              "below me you find your Products ^_^",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            Container(
              width: double.infinity,
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
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //childAspectRatio: 3 / 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 2),
                  itemCount: profile.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              int id = profile[index].id!;
                              selectShowOneProduct(context, id);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        ServerConfig.domainNameServer +
                                            profile[index].imageUrl!),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 8,
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Are you sure ?"),
                                          content: Text("Delete ?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  int product_id =
                                                      profile[index].id!;
                                                  reaction.deleteProduct(
                                                      product_id);

                                                  profile.removeAt(index);
                                                  setState(() {
                                                    profile = profile;
                                                  });
                                                  return Navigator.of(context)
                                                      .pop();
                                                },
                                                child: Text("Yes")),
                                            TextButton(
                                                onPressed: () {
                                                  return Navigator.of(context)
                                                      .pop();
                                                },
                                                child: Text("No")),
                                          ],
                                          elevation: 24.0,
                                        ),
                                    barrierDismissible: true);
                                // AlertDialog(
                                //   title: Text("Are You Sure?"),
                                //   content: Text("Delete?"),
                                //   actions: [
                                //     TextButton(onPressed: (){}, child: Text("Yes")),
                                //     TextButton(onPressed: (){}, child: Text("No")),
                                //   ],
                                //   elevation: 24.0,
                                //   backgroundColor: Colors.deepOrange,
                                // );

                                // int product_id = profile[index].id!;
                                // reaction.deleteProduct(product_id);

                                // profile.removeAt(index);
                                // setState(() {
                                //   profile = profile;
                                // });
                              },
                              icon: Icon(Icons.delete),
                              iconSize: 25.0,
                              color: Colors.red,
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 8,
                            child: IconButton(
                              onPressed: () {
                                int id = profile[index].id!;
                                selectEditPage(context, id);
                              },
                              icon: Icon(Icons.edit),
                              iconSize: 25.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              //return CircularProgressIndicator();
            ),
            // child: GridView.builder(
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         //childAspectRatio: 3 / 2,
            //         crossAxisSpacing: 5,
            //         mainAxisSpacing: 5,
            //         crossAxisCount: 2),
            //     itemCount: Utils.getproduct.length,
            //     itemBuilder: (context, index) {
            //       return Center(
            //         child: Container(
            //           decoration: BoxDecoration(
            //             image: DecorationImage(
            //                 image: NetworkImage(
            //                     Utils.getproduct[index].imageUrl!),
            //                 fit: BoxFit.fill),
            //             borderRadius: BorderRadius.circular(15),
            //           ),
            //         ),
            //       );
            //     }),
            // Expanded(child: GridView(
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2,
            //           mainAxisSpacing: 2.0,
            //           crossAxisSpacing: 2.0,
            //         ),
            //         children: List.generate(
            //           categories.length,
            //               (index) =>
            //                   // CircleAvatar(
            //                   //   backgroundColor: Colors.deepOrange,
            //                   //   //backgroundImage:
            //                   //   radius: 56,
            //                   //   backgroundImage: NetworkImage(
            //                   //       categories[index]),
            //                   // )
            //           Image(
            //           height: double.infinity,
            //           width: double.infinity,
            //           image: AssetImage('assets/images/' + categories[index].imgName + '.jpg'),
            //           fit: BoxFit.cover,
            //         ),
            //         ),
            //       ), )
          ],
        ),
      ),
    );
  }
}
