import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:store/api/reaction.dart';
import 'package:store/widgets/profile.dart';

class Edit extends StatefulWidget {
  int id;

  Edit({required this.id});

  @override
  _EditState createState() => _EditState(id: this.id);
}

class _EditState extends State<Edit> {
  int id;

  _EditState({required this.id});

  TextEditingController name = new TextEditingController();

  TextEditingController quantity = new TextEditingController();

  Reaction reaction = Reaction();

  void profileScreen(BuildContext ctx) {
    Navigator.of(ctx).pop(
      MaterialPageRoute(
        builder: (_) {
          return Profile();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Details"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
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
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  cursorColor: Colors.black,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                    hintText: 'Available Amount ',
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
                  controller: quantity,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  if (name.text.isEmpty) {
                    name.text = 'zzzzzz';
                  }
                  if (quantity.text.isEmpty) {
                    quantity.text = '123454321';
                  }
                  EasyLoading.show(status: 'Loading...', dismissOnTap: true);

                  if (await reaction.editproduct(
                      id, quantity.text, name.text)) {
                    EasyLoading.showSuccess('Done!');
                    profileScreen(context);
                  } else {
                    EasyLoading.showError('Error!');
                  }
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                label: Text(
                  'Edit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
