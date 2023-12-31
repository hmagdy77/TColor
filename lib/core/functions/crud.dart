import 'dart:convert';

import 'package:http/http.dart' as http;

class Crud {
  static getRequest(String url) async {
    var response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return body;
      } else {
        // print('response statusCode $response.statusCode');
      }
    } catch (e) {
      // print('Catched Error $e');
    }
  }

  static postRequest(
      {required String url,
      required Map data,
      required Function function}) async {
    var response = await http.post(Uri.parse(url), body: data);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = response.body;
        return function(jsonData);
      } else {}
    } catch (e) {
      // print('Catched Error $e***************');
    }
  }
}
