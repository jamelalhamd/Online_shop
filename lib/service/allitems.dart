import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping/modal/itemmodal.dart';

class Allitems {
  Future<List<Producktmodal>> getallitems() async {
    var url = Uri.parse('https://fakestoreapi.com/products');
    List<Producktmodal> items = [];

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        // Loop through the data
        for (int i = 0; i < data.length; ++i) {
          try {
            var product = Producktmodal.fromJson(data[i]);
            items.add(product);
          } catch (e) {}
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } on Exception catch (e) {
      throw Exception('Request failed with status: ${e.toString()}.');
    }

    return items;
  }
}
