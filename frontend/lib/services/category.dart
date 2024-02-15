import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/global/globalData.dart';
import 'package:frontend/models/category.dart';
import 'package:http/http.dart' as http;

Future getCategory(context) async {
  var response =
      await http.get(Uri.parse('http://192.168.0.10:5000/getCategoryList'));
  if (response.statusCode == 200) {
    var categoryListFinal = jsonDecode(response.body) as List;
    categoryList =
        categoryListFinal.map((e) => CategoryModel.fromJson(e)).toList();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error in retrivenig state list")));
  }
}
