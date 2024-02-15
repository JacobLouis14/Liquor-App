import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/////////////////////////File IMPORT
import 'package:frontend/models/user.dart';
import 'package:frontend/global/globalData.dart';

Future checkUserLoggedIn(context) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  String? userToken = localStorage.getString('userToken');

  // Accesing User Data
  if (userToken != null) {
    var response = await http.get(
        Uri.parse('http://192.168.0.10:5000/users/userdata'),
        headers: {"Authorization": "Bearer $userToken"});

    ///Response
    if (response.statusCode == 200) {
      final finalResponseBody =
          jsonDecode(response.body) as Map<String, dynamic>;
      final finalUserData = User.fromJson(finalResponseBody);
      userData = finalUserData;
      //intializing wishlist
      wishListProductData?.addAll(userData?.wishlist ?? []);
      isLogged.value = true;
    } else if (response.statusCode == 401) {
      isLogged.value = false;
      localStorage.remove('userToken');
      userData = null;
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Some thing went wrong"),
          content: const Text("Login to continue"),
          actions: [
            TextButton(
                onPressed: () =>
                    {authValueChanger.value = 1, Navigator.pop(context, "")},
                child: const Text("Login"))
          ],
        ),
      );
    }
  }
}
