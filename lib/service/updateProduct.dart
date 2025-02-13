import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/modal/itemmodal.dart';

Future<Producktmodal> updateProduct({
  required int id,
  required String title,
  required double price,
  required String description,
  required String category,
  required String image,
  String? token, // التحقق من الـ token
}) async {
  var url = Uri.parse('https://fakestoreapi.com/products/$id');

  Map<String, String> header = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  // إذا كان الـ token موجودًا، أضفه إلى الـ header
  if (token != null && token.isNotEmpty) {
    header.addAll({'Authorization': 'Bearer $token'});
  }

  Map<String, String> body = {
    'id': id.toString(),
    'title': title,
    'price': price.toString(), // تأكد من أن السعر هو String
    'description': description,
    'category': category,
    'image': image,
  };

  try {
    var response = await http.put(
      url,
      body: body, // تأكد من أن الجسم مشفر بشكل صحيح
      headers: header,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Producktmodal.fromJson(data);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Request failed: ${e.toString()}');
    throw Exception('Request failed: ${e.toString()}');
  }
}
