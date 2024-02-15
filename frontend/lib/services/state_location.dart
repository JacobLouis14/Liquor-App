import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//////////////////////File Import
import 'package:frontend/models/state.dart';
import 'package:frontend/global/globalData.dart';

Future stateLocation(context) async {
  var response =
      await http.get(Uri.parse('http://192.168.0.10:5000/listState'));
  if (response.statusCode == 200) {
    var stateListFinal = jsonDecode(response.body) as List;
    stateList = stateListFinal.map((e) => StateModel.fromJson(e)).toList();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error in retrivenig state list")));
  }
}
