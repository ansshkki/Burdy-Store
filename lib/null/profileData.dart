/*import 'package:zass/api/service-config.dart';

import 'UserSecureStorage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileData{
   
   var url = Uri.parse(ServerConfig.domainNameMobileServer + ServerConfig.Profile);

   Future<List<GetProducts>> profile() async {
    var token = await UserSecureStorage.getToken();
    print(token! + " haha");
    var header = {
      "Authorization": "Bearer " + token,
      'Accept': 'application/json',
      'id': 1.toString()
    };
    http.Response response = await http.get(url, headers: header);

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
    }}

}
*/
