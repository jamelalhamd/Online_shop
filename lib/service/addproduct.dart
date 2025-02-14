import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/modal/itemmodal.dart';

Future<Producktmodal> addProduct({
  required String title,
  required String price,
  required String description,
  required String category,
  required String image,
  @required String? token,
}) async {
  var url = Uri.parse('https://fakestoreapi.com/products');

  Map<String, String> headers = {
    "Content-Type":
        "application/x-www-form-urlencoded", // Ensure proper JSON format
  };

  if (token != null && token.isNotEmpty) {
    headers["Authorization"] = "Bearer $token";
  }

  Map<String, dynamic> body = {
    'title': title,
    'price': price, // Ensure it's a string
    'description': description,
    'image': image,
    'category': category,
  };

  try {
    var response = await http.post(
      url,
      headers: headers,
      body: body, // Encode JSON properly
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return Producktmodal.fromJson(data);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: ${e.toString()}');
  }
}
