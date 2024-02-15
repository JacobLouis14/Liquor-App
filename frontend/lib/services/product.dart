import 'dart:convert';
import 'package:http/http.dart' as http;

///////////////////File Import
import 'package:frontend/models/product.dart';
import 'package:frontend/global/globalData.dart';

Future getProductDetails() async {
  var response =
      await http.get(Uri.parse("http://192.168.0.10:5000/getProductList"));
  var productDataFinal = jsonDecode(response.body) as List;
  productDataList =
      productDataFinal.map((e) => ProductModel.fromJson(e)).toList();
}
