import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:store/api/reaction.dart';
import 'package:store/models/commentmodel.dart';
import 'package:store/widgets/bottombar.dart';

class Comment extends StatefulWidget {
  int id;

  Comment({required this.id});

  @override
  _CommentState createState() => _CommentState(id: this.id);
}

class _CommentState extends State<Comment> {
  int id;

  _CommentState({required this.id});

  final GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  Reaction reaction = Reaction();

  void bottomBarScreen(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return BottomBar();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              return bottomBarScreen(context);
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Comment',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.77,
            child: FutureBuilder<List<CommentModel>>(
              future: reaction.getComments(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.16,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Card(
                                color: Colors.grey[200],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '  ' + snapshot.data![index].username!,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.deepOrange[600],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        '  ' + snapshot.data![index].body!,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.deepPurple,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  EasyLoading.showError('');
                  return Text(snapshot.error.toString());
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),

          ////////////////

          Column(
            children: [
              Divider(
                color: Colors.deepOrange,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 12,
                      child: Container(
                        //  height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Form(
                          key: formkey1,
                          child: TextFormField(
                            //readOnly: true,
                            // expands: true,
                            maxLength: 100,
                            // maxLines: null,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            decoration: InputDecoration(
                              hintText: 'type a message: ',
                              border: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                            controller: name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "type a message";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: IconButton(
                        onPressed: () async {
                          //make a validation condition
                          if (formkey1.currentState!.validate()) {
                            EasyLoading.show(
                                status: 'Loading...', dismissOnTap: true);

                            if (await reaction.sendComments(id, name.text)) {
                              EasyLoading.showSuccess('Done!');
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return Comment(id: id);
                                  },
                                ),
                              );
                            } else {
                              EasyLoading.showError('Error!');
                            }
                          }
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.deepOrange,
                        ),
                        iconSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
