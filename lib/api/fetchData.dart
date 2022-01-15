import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/api/securestorage.dart';
import 'package:store/config/service-config.dart';
import 'package:store/models/getproductsclass.dart';
import 'package:store/models/oneproductclass.dart';

//class to get all data of products
class FetchData {
  //var url_Prod = Uri.parse('http://192.168.1.100:8000/api/products'); //store
  // var url_Prod =
  //     Uri.parse(ServerConfig.domainNameMobileServer + ServerConfig.allproduct);
  //final MAIN_URL = "http://192.168.1.104:8000";

  SecureStorage storage = SecureStorage();

  Future<List<GetProducts>> fetchProducts() async {
    var url_Prod =
        Uri.parse(ServerConfig.domainNameServer + ServerConfig.allproduct);
    var token = await storage.read();
    print(token! + " haha");
    var header = {
      "Authorization": "Bearer " + token,
      'Accept': 'application/json'
    };
    http.Response response = await http.get(url_Prod, headers: header);

    if (response.statusCode == 200) {
      print(response.statusCode);

      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      print(response.body);
      return parsed
          .map<GetProducts>((item) => GetProducts.fromJson(item))
          .toList();
    } else {
      print(response.statusCode);
      return [];
    }

    // if (response.statusCode == 200) {
    //   var body = jsonDecode(response.body);
    //   print(response.body);
    //   List<GetProducts> allproducts = [];
    //   for (var prod in body) {
    //     allproducts.add(GetProducts.fromJson(prod));
    //   }
    //   print("it's working !");
    //   return allproducts;
    // } else {
    //   print(response.statusCode);
    //   return [];
    // }
  }

  Future<List<OneProduct>> fetchProfile() async {
    var url_Profile =
        Uri.parse(ServerConfig.domainNameServer + "/api/products/get");

    var token = await storage.read();
    var header = {
      "Authorization": "Bearer " + token!,
      'Accept': 'application/json'
    };
    http.Response response = await http.post(url_Profile, headers: header);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print(response.statusCode);

      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      print(response.body);
      return parsed
          .map<OneProduct>((item) => OneProduct.fromJson(item))
          .toList();
    } else {
      print(response.statusCode);
      return [];
    }
  }
}
