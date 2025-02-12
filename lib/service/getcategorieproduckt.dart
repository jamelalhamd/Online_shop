import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping/modal/itemmodal.dart';

class Allcategoreitems {
  Future<List<Producktmodal>> getcategoryitems(
      {required String Catergory}) async {
    var url =
        Uri.parse('https://fakestoreapi.com/products/category/${Catergory}');
    List<Producktmodal> items = [];

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (int i = 0; i < data.length; ++i) {
          items.add(Producktmodal.fromJson(data[i]));
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } on Exception catch (e) {
      print('Request failed with status: ${e.toString()}');
      throw Exception('Request failed with status: ${e.toString()}.');
    }
    return items;
  }
}
