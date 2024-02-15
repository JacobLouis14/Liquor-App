import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class stateAdd extends StatefulWidget {
  const stateAdd({super.key});

  @override
  State<stateAdd> createState() => _stateAddState();
}

//State form key
final stateFormKey = GlobalKey<FormState>();

class _stateAddState extends State<stateAdd> {
//Form Field Controller
  TextEditingController stateTextController = TextEditingController();

//State Adding Handler
  void stateAddingFunction() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? userToken = localStorage.getString('userToken');
    var response =
        await http.post(Uri.parse('http://192.168.0.10:5000/createState'),
            headers: {
              "Authorization": "Bearer $userToken",
              "content-type": "application/json; charset=UTF-8"
            },
            body: jsonEncode({"StateName": stateTextController.text}));
    ///////////////////OK Response
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          icon: Icon(
            Icons.check_circle,
            size: 60,
            color: Colors.green,
          ),
          title: Text("Successfully Created"),
        ),
      );
    }
    ///////////////////Failed Response
    if (response.statusCode != 200) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (BuildContext context) => const AlertDialog(
                icon: Icon(
                  Icons.error,
                  size: 60,
                  color: Colors.red,
                ),
                title: Text("Failed To Create"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Add State",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: stateFormKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: stateTextController,
                decoration: const InputDecoration(hintText: "New State"),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                  style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size(400, 50)),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.lightGreen)),
                  onPressed: () => {
                        if (stateFormKey.currentState!.validate())
                          {stateAddingFunction()}
                      },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Add State",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
