import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/api/securestorage.dart';
import 'package:store/config/service-config.dart';
import 'package:store/models/commentmodel.dart';

class Reaction {
  SecureStorage storage = SecureStorage();

  Future<bool> likeReaction(int product_id) async {
    print(product_id);
    var url = Uri.parse(
        ServerConfig.domainNameServer + "/api/products/${product_id}/likes");
    print(url);
    var token = await storage.read();

    var response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer " + token!,
      },
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print("likes is done");
      return true;
    } else {
      print("sorry you can like this");
      print(response.statusCode);
      return false;
    }
  }

  Future<List<CommentModel>> getComments(int product_id) async {
    var url = Uri.parse(
        ServerConfig.domainNameServer + "/api/products/${product_id}/comments");
    var token = await storage.read();

    var response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer " + token!,
      },
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print(response.statusCode);
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      print(response.body);
      return parsed
          .map<CommentModel>((item) => CommentModel.fromJson(item))
          .toList();
    } else {
      print(response.body);
      print(response.statusCode);
      return [];
    }
  }

  Future<bool> sendComments(int product_id, String text) async {
    var url = Uri.parse(
        ServerConfig.domainNameServer + "/api/products/${product_id}/comments");
    var token = await storage.read();

    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      "Authorization": "Bearer " + token!,
    }, body: {
      "body": text
    });

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print(response.statusCode);
      print("the product is removed");
      return true;
    } else {
      print("sorry you can delete product");
      print(response.statusCode);
      return false;
    }
  }

  Future<bool> deleteProduct(int product_id) async {
    var url = Uri.parse(ServerConfig.domainNameServer +
        "/api/products/${product_id}?_method=DELETE");
    var token = await storage.read();

    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      "Authorization": "Bearer " + token!,
    });

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print("the product is removed");
      return true;
    } else {
      print("sorry you can delete product");
      print(response.statusCode);
      return false;
    }
  }

  Future<bool> editproduct(int prodId, String amount, String name) async {
    var url4 = Uri.parse(ServerConfig.domainNameServer +
        ServerConfig.newproduct +
        '$prodId?_method=PUT');
    var token = await storage.read();
    print(token! + " hahaSSS");
    var header = {
      "Authorization": "Bearer $token",
      'Accept': 'application/json'
    };
    var body = {
      "quantity": amount,
      "name": name,
    };
    http.Response response = await http.post(url4, headers: header, body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

/*static Future<bool> editProduct(data, product_id) async {
    var url = Uri.parse(
        ServerConfig.domainNameServer + "/api/products/${product_id}");
    var token = await UserSecureStorage.getToken();

    var response = await http.put(url, headers: {
      'Accept': 'application/json',
      "Authorization": "Bearer " + token!,
    });
  }*/
}
