import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  String url = "https://retoolapi.dev/OYDi0z/login_data";

  //Sample API response
  Future<String> fetchData() async {
    return http.get(Uri.parse(url)).then((value) {
      List<dynamic> decodedResponse = jsonDecode(value.body);
      return decodedResponse.first["isUser"];
    });
  }
}
