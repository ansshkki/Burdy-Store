import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/api/securestorage.dart';
import 'package:store/config/service-config.dart';
import 'package:store/models/getproductsclass.dart';

SecureStorage storage = SecureStorage();

//class to get all data of products
class FetchSearchedData {
//   List<GetProducts> listcat=[];
  SecureStorage storage = SecureStorage();
  bool prints = false;
  var url1 = Uri.parse(ServerConfig.domainNameServer + ServerConfig.search);

  var url2 =
      Uri.parse(ServerConfig.domainNameServer + ServerConfig.sort); //store

  var url3 =
      Uri.parse(ServerConfig.domainNameServer + ServerConfig.logout); //logout

//get all products from backend
  Future<List<GetProducts>> fetchProducts(String id) async {
    var token = await storage.read();
    print(token! + " hahaSSS");
    var header = {
      "Authorization": "Bearer $token",
      'Accept': 'application/json'
    };
    var body = {
      "category_id": id,
    };
    http.Response response = await http.post(url1, headers: header, body: body);

    if (response.statusCode == 200) {
      print(response.statusCode);
      prints = true;
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      print(response.body);
      return parsed
          .map<GetProducts>((item) => GetProducts.fromJson(item))
          .toList();
    } else {
      print(response.body);
      print(response.statusCode);
      return [];
    }
  }

  Future<List<GetProducts>> fetchSearchedProducts(
      String name, String price, String id, String date, bool p) async {
    var token = await storage.read();
    if (p == true) {
      print(token! + " hahaSSS");
      var header = {
        "Authorization": "Bearer $token",
        'Accept': 'application/json'
      };
      var body = {
        "name": name,
        "upPrice": price,
        "category_id": id,
        "expiration_date": date
      };
      http.Response response =
          await http.post(url1, headers: header, body: body);

      if (response.statusCode == 200) {
        print(response.statusCode);
        prints = true;
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        print(response.body);
        return parsed
            .map<GetProducts>((item) => GetProducts.fromJson(item))
            .toList();
      } else {
        print(response.body);
        print(response.statusCode);
        return [];
      }
    } else
      return [];
  }

  Future<List<GetProducts>> sortProducts(String id) async {
    var token = await storage.read();
    print(token! + " hahaSSS");
    var header = {
      "Authorization": "Bearer $token",
      'Accept': 'application/json'
    };
    var body = {
      "id": id,
    };
    http.Response response = await http.post(url2, headers: header, body: body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      prints = true;
      try {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        print(
            "parsed: ${parsed.map<GetProducts>((item) => GetProducts.fromJson(item)).toList()}");
        return parsed
            .map<GetProducts>((item) => GetProducts.fromJson(item))
            .toList();
      } catch (e) {
        print("error: $e");
        return [];
      }
    } else {
      print(response.body);
      print(response.statusCode);
      return [];
    }
  }

//func to logout
  Future<bool> logoutAuth() async {
    var token = await storage.read();
    print(token! + " hahaSSS");
    var header = {
      "Authorization": "Bearer $token",
      'Accept': 'application/json'
    };
    http.Response response = await http.post(url3, headers: header);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

//func to edit
/*
 Future<bool> editproduct(int prodId,String amount/* and anything else we want to edit*/) async {
   var url4 = Uri.parse(ServerConfig.domainNameServer + ServerConfig.newproduct+'$prodId');
    var token = await storage.read();
    print(token! + " hahaSSS");
    var header = {
      "Authorization": "Bearer $token",
      'Accept': 'application/json'
    };
    var body = {
      "quantity":amount,
    };
    http.Response response = await http.put(url4, headers: header,body: body);

    if (response.statusCode == 200) {
     return true;
    } else {
     return false;
    }
  }





//func to get comment
Future<List<GetProducts>> getComments(int id) async {
    var token = await storage.read();
    var url4 =
      Uri.parse(ServerConfig.domainNameServer + ServerConfig.newproduct+'$id');
    print(token! + " hahaSSS");
    var header = {
      "Authorization": "Bearer $token",
      'Accept': 'application/json'
    };
    http.Response response = await http.get(url4, headers: header);

    if (response.statusCode == 200) {
      print(response.statusCode);
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      print(response.body);
      return parsed
          .map<GetProducts>((item) => GetProducts.fromJson(item))
          .toList();
    } else {
      print(response.body);
      print(response.statusCode);
      return [];
    }
  }
  */
