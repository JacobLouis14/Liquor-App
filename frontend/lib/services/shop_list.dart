import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/shop.dart';
import 'package:http/http.dart' as http;

////////////////////////////FIle Import
import 'package:frontend/global/globalData.dart';

Future<void> getShopList(context) async {
  var response =
      await http.get(Uri.parse("http://192.168.0.10:5000/getshoplist"));
  if (response.statusCode == 200) {
    var shopFinalList = jsonDecode(response.body) as List;
    shopListData =
        shopFinalList.map((element) => ShopModel.fromJson(element)).toList();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error in retrivenig state list")));
  }
}
