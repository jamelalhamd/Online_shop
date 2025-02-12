import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({required String link}) async {
    try {
      Uri url = Uri.parse(link);
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'there is ierror instatusCode = ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('there is ierror instatusCode = ${e}');
    }
  }
}
