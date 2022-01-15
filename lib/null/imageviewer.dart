/*


class ImageWidget extends StatelessWidget {
 final File image;
 final ValueChanged<ImageSource> onClicked;

const ImageWidget({
  Key? key,
  required this.image,
  required this.onClicked,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color= Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(context),
          Positioned(child: buildEditIcon(color),
          bottom: 0,
          right: 4,
          )
      ],),
    );
  }

  Widget buildImage(BuildContext context){
    final imagePath = this.image.path;


  }


}










  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }









  Column(
                children: [
                  Text(
                    'pick photo for the product: ',
                    style: TextStyle(color: Colors.black54),
                  ),
                  image != null ? Image.file(image!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  )
                  : FlutterLogo(size: 150,),
                  buildButton(
                    title: 'pick from gallery',
                    icon: Icons.image_outlined,
                    onClicked: () => pickImage(ImageSource.gallery),
                  ),
                  buildButton(
                    title: 'pick from camera',
                    icon: Icons.camera_alt_outlined,
                    onClicked: () => pickImage(ImageSource.camera),
                  )
                ],
              ),
*/

/*
  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            child: imageFile != null
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(imageFile),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/imagess.jpeg'),
                    )),
                  ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => bottomSheet()));
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.deepOrange,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'pick photo for the product: ',
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              Spacer(),
              ElevatedButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Gallery'))
            ],
          ),
        ],
      ),
    );
  }

 */

/* 100% works

 XFile? _image;

  Future takePhotoFromGallery() async {
    final XFile? selectedImage = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 75, maxWidth: 75);

    setState(() {
      _image = selectedImage;
    });
  }

  Future takePhotoFromCamera() async {
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = selectedImage;
    });
  }

  final picker = ImagePicker();




in build


  Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: _image == null
                        ? Text(
                            ' No image is picked ',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          )
                        : Image.file(
                            File(_image!.path),
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
                height: 20,
              ),



        /*
        first try of sending data to back

         http.post(
                    Uri.parse(
                        "https://myzass123-default-rtdb.europe-west1.firebasedatabase.app/addProduct.json"),
                    body: jsonEncode(
                      <String, String>{
                        'name': name.text,
                        //'contact number'  : contactnumber,
                        // 'expiration Date' : _myDateTime.toString(),
                        // 'category' : category,
                        // 'available amount' : availableAmount
























        */


                //  _addNewProduct();
                 // bottomBarScreen(context);
                  http.post(
                    Uri.parse("https://myzass123-default-rtdb.europe-west1.firebasedatabase.app/addProduct.json"),
                    body: jsonEncode(
                      <String, String>{
                        'name': name.text,
                        'baseprice' : price.text,
                        'aftersale1price' : (double.parse(price.text) *  (widget.sales1!)).toString(),


                        //'contact number'  : contactnumber,
                        // 'expiration Date' : _myDateTime.toString(),
                        // 'category' : category,
                        // 'available amount' : availableAmount




 */

/*
  Future<Album> sendProductInfo(String name,/*DateTime expirationdate,*/ double amount ,double price) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/products/'),
    headers: <String, String>{
      'Accept': 'application/json',
    },
    body: jsonEncode({
      'name': name,
      //'expiration_date' : expirationdate,
      'quantity':amount,
      'price' : price
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(Album.fromJson(jsonDecode(response.body)));
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<Album>? _futureAlbum;
*/

/*
in on pressed
                     _futureAlbum = sendProductInfo(name.text,double.parse(availableAmount.text),double.parse(price.text));


                     */

/*



                    final periods = [
                                            {
                                              'date':
                                                  expirationDate3.toString(),
                                              'sale': sale3.toString()
                                            },
                                            {
                                              'date':
                                                  expirationDate2.toString(),
                                              'sale': sale2.toString()
                                            },
                                            {
                                              'date':
                                                  expirationDate1.toString(),
                                              'sale': sale1.toString()
                                            },
                                          ];
                                          setState(() {
                                            sale3 = sale3;
                                            sale2 = sale2;
                                            periodsString = jsonEncode(periods);
                                            print(periodsString);
                                          });
                                        },



                     */

/*   DefaultTabController(
                length: 4,
                child: Container(
                  width: double.infinity,
                  child: Expanded(
                    flex: 20,
                    child: TabBar(
                      indicatorColor: Colors.deepOrange,
                      //indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Colors.deepOrange,
                      isScrollable: false,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.indigo[300],
                      tabs: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              id = '1';
                            });
                          },
                          child: Tab(
                            text: '      Sports       ',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              id = '2';
                            });
                          },
                          child: Tab(
                            text: '      Technology      ',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              id = '3';
                            });
                          },
                          child: Tab(
                            text: '         Food         ',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              id = '4';
                            });
                          },
                          child: Tab(
                            text: '      Others        ',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/

//to add new products
/* void _addNewProduct() {
      final newpx = AddProduct(
        name: name.text,
        image: imageController!,
        expirationdate: expirationDate,
        category: valueChoosen!,
        category_id: double.parse(id),
        contactNumber: double.parse(contactNumber.text),
        quantity: double.parse(availableAmount.text),
        basicprice: double.parse(price.text),
        periods: periodsString,
        // double.parse(price.text) * (widget.sales3!)
      );

      setState(() {
        prod = newpx;
        print('done getting products from inputs');
        print('/n');
      });
    }*/
