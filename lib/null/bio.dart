import 'package:flutter/material.dart';

class Bio extends StatefulWidget {
  @override
  _StateBio createState() => _StateBio();
}

class _StateBio extends State<Bio> {
  TextEditingController biotext = new TextEditingController();

  void selectBio(BuildContext ctx) {
    setState(() {
      Navigator.of(ctx).pop(biotext.text);
    });
  }

  /*
   message['user']['email']


   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.deepOrange,
        child: Center(
          child: Column(
              children: [
            Container(
              height: 300,
              width: 300,
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(
                  // fillColor: Colors.white,
                  // focusColor: Colors.white,
                  // hoverColor: Colors.white,
                  hintText: "Bio",
                ),
                keyboardType: TextInputType.name,
                controller: biotext,
                style: TextStyle(height: 20),
                // style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              child: OutlinedButton(
                child: Text("Edit", style: TextStyle(fontSize: 15)),
                onPressed: () {
                  selectBio(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(40, 10, 40, 10))),
              ),
            ),
          ].toList()),
        ),
      ),
    );
  }
}
