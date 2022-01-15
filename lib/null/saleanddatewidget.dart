import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaleDate extends StatefulWidget {
  @override
  _SaleDateState createState() => _SaleDateState();
}

class _SaleDateState extends State<SaleDate> {
  String time1 = "?", time2 = "?", time3 = "?";

  DateTime? _expirationDate1, _expirationDate2, _expirationDate3;

  double sale1 = 0, sale2 = 41, sale3 = 71;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                'choose a date and a sale percentage because after this date the sale percentage will be applied'
                    .toUpperCase(),
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 2),
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
              ElevatedButton(
                onPressed: () async {
                  _expirationDate1 = await showDatePicker(
                    context: context,
                    initialDate: _expirationDate1 == null
                        ? DateTime.now()
                        : _expirationDate1!,
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2030),
                  );

                  setState(
                    () {
                      time1 =
                          DateFormat('dd-MM-yyyy').format(_expirationDate1!);
                    },
                  );
                },
                child: Text('1st sale date'),
              ),
              Slider(
                  value: sale1,
                  min: 0,
                  max: 40,
                  onChanged: (newPrice) {
                    setState(() {
                      sale1 = newPrice;
                    });
                  }),
              Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 2),
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
              ElevatedButton(
                onPressed: () async {
                  _expirationDate2 = await showDatePicker(
                    context: context,
                    initialDate: _expirationDate2 == null
                        ? DateTime.now()
                        : _expirationDate2!,
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2030),
                  );

                  setState(
                    () {
                      time2 =
                          DateFormat('dd-MM-yyyy').format(_expirationDate2!);
                    },
                  );
                },
                child: Text('2nd sale date'),
              ),
              Slider(
                  value: sale2,
                  min: 41,
                  max: 70,
                  onChanged: (newPrice) {
                    setState(() {
                      sale2 = newPrice;
                    });
                  }),
              Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 2),
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
              ElevatedButton(
                onPressed: () async {
                  _expirationDate3 = await showDatePicker(
                    context: context,
                    initialDate: _expirationDate3 == null
                        ? DateTime.now()
                        : _expirationDate3!,
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2030),
                  );

                  setState(
                    () {
                      time3 =
                          DateFormat('dd-MM-yyyy').format(_expirationDate3!);
                    },
                  );
                },
                child: Text('3rd sale date'),
              ),
              Slider(
                  value: sale3,
                  min: 71,
                  max: 99,
                  onChanged: (newPrice) {
                    setState(() {
                      sale3 = newPrice;
                    });
                  }),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed:
                    () {} /*
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyAddNewProductPage(
                        sales1: (100-sale1)/100,
                        sales2: (100-sale1)/100,
                        sales3: (100-sale1)/100,
                      ),
                    ),
                  );
                }*/
                ,
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
            ],
          ),
        ),
      ),
    );
  }
}
