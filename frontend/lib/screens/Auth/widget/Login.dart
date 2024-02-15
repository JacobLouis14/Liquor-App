// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

///////////////////////////////File Import
import 'package:frontend/models/user.dart';
import 'package:frontend/global/globalData.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //////////////////////////Global variable
  bool passwordIsNotVisible = true;

  //////////////////// Login Form Data
  final _loginFormData = GlobalKey<FormState>();

  //////////////Data variable & Function to pass login data to backend
  var emailData = TextEditingController();
  var passwordData = TextEditingController();
  void loginHandler() async {
    var response = await http.post(
        Uri.parse('http://192.168.0.10:5000/users/login'),
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: jsonEncode(
            {"email": emailData.text, "password": passwordData.text}));

    /////////////////////////HAndling response
    if (response.statusCode == 200) {
      final responseBodyJson =
          jsonDecode(response.body) as Map<String, dynamic>;
      final finalUserData = UserData.fromJson(responseBodyJson);

      ////////////////////saving user id to local Storage
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("userToken", finalUserData.token!);
      isLogged.value = true;
      userData = finalUserData.user;
      ///////////////////////redirecting to homescreen
      indexChanger.value = 0;
      Navigator.pushNamedAndRemoveUntil(
          context, "/entrypoint", (route) => false);
    } else if (response.statusCode == 401) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          title: Text("Invalid Credentials"),
          content: Text("How you can forget me?"),
        ),
      );
    } else if (response.statusCode == 404) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Account not exist"),
          content: const Text("Hurry up, Lets create one?"),
          actions: [
            TextButton(
                onPressed: () =>
                    {authValueChanger.value = 1, Navigator.pop(context, "")},
                child: const Text("Register"))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authValueChanger,
      builder: (context, int value, _) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Form(
              key: _loginFormData,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.network(
                    'https://img.freepik.com/free-vector/security-concept-illustration_114360-497.jpg?w=740&t=st=1703995248~exp=1703995848~hmac=cdf8fc8e3e1147bf936aedb6aa214af1771365de3f978c23cc93a9e8b669e278',
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: emailData,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordData,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        hintText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () => setState(() {
                            passwordIsNotVisible = !passwordIsNotVisible;
                          }),
                          child: Icon(passwordIsNotVisible
                              ? Icons.visibility_off_rounded
                              : Icons.visibility),
                        )),
                    obscureText: passwordIsNotVisible,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: Size(400, 50),
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(fontSize: 20)),
                      onPressed: () => {
                            if (_loginFormData.currentState!.validate())
                              {loginHandler()}
                          },
                      child: Text("Login")),
                  SizedBox(
                    height: 50,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Don't have an account "),
                    InkWell(
                      onTap: () => {authValueChanger.value = 1},
                      child: Text(
                        "SignUp ?",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green[300],
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ]),
                ],
              )),
        );
      },
    );
  }
}
