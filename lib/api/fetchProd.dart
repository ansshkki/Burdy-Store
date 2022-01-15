import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:store/api/securestorage.dart';
import 'package:store/config/service-config.dart';
import 'package:store/models/getproductsclass.dart';
import 'package:store/models/oneproductclass.dart';

//class to get one product deatils.
class FetchProd {
  //int? index;
  //var url_Prod = Uri.parse('/'); //store

  SecureStorage storage = SecureStorage();

  Future<OneProduct> fetchProd(int index) async {
    var id = (index).toString();
    print("this is test in fetch prod");
    print(id);
    //var url = Uri.parse('$MAIN_URL/api/products/$id');
    var url = Uri.parse(ServerConfig.domainNameServer + '/api/products/$id');
    print(url);
    var token = await storage.read();
    print(token! + " haha2");
    var header = {
      "Authorization": "Bearer " + token,
      'Accept': 'application/json'
    };
    http.Response response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      print("okok");

      try {
        final parsed = jsonDecode(response.body) as Map<String, dynamic>;
        var product = OneProduct.fromJson(parsed);
        print(product.name);
        print("ok");
        print(response.body);
        return product;
        //.map<OneProduct>((item) => OneProduct.fromJson(item))
        //.toList();
      } catch (e) {
        print(e);
        throw e;
      }
    } else {
      print(e);
      throw e;
    }
  }
}
