import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/modal/itemmodal.dart';

class AddProduct {
  Future<Producktmodal> addProduct({
    required String title,
    required String price,
    required String description,
    required String category,
    required String image,
    @required String? token,
  }) async {
    var url = Uri.parse('https://fakestoreapi.com/products');

    Map<String, String> header = {};
    Map<String, String> body = {
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
    };

    if (token != null) {
      header.addAll({'Authorization': 'Bearer $token'});
    }
    try {
      // Sending POST request with JSON body
      var response = await http.post(
        url,
        body: jsonEncode(body), // Ensure body is properly encoded
        headers: header,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return Producktmodal.fromJson(data);
      } else {
        // Throw an exception for non-200 status code
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error and rethrow
      print('Request failed: ${e.toString()}');
      throw Exception('Request failed: ${e.toString()}');
    }
  }
}
