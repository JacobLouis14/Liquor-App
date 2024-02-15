// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

/////////////////////////////File Import
import 'package:frontend/models/user.dart';
import 'package:frontend/global/globalData.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Form Data
  final _signupFormKey = GlobalKey<FormState>();

  //Global Variable
  bool passwordIsNotVisible = true;

  //SignUp variables and Functions
  var nameData = TextEditingController();
  var emailData = TextEditingController();
  var passwordData = TextEditingController();
  var dateOfBirthData = TextEditingController();
  DateTime? rawDate;
  void signUpHandler() async {
    var response =
        await http.post(Uri.parse('http://192.168.0.10:5000/users/signup'),
            headers: {"content-type": "application/json; charset=UTF-8"},
            body: jsonEncode({
              "name": nameData.text,
              "email": emailData.text,
              "password": passwordData.text,
              "dateOfBirth": dateOfBirthData.text,
            }));

    //Clearing the fields
    setState(() {
      nameData.text = "";
      emailData.text = "";
      passwordData.text = "";
      dateOfBirthData.text = "";
    });

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
    }
    if (response.statusCode == 401) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Alredy Have An Account"),
          content: const Text("Is it true that you not remembering me?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, "No"),
                child: const Text("No")),
            TextButton(
                onPressed: () =>
                    {authValueChanger.value = 0, Navigator.pop(context, "")},
                child: const Text("Login"))
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
              key: _signupFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.network(
                    'https://img.freepik.com/free-vector/select-concept-illustration_114360-383.jpg?t=st=1703996298~exp=1703996898~hmac=70c7a003bc1ee5fb213d37fde62e10d7246653c0c7055fe08f0020e430d3e00e',
                    scale: 3,
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameData,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.abc),
                      hintText: 'Name',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: dateOfBirthData,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      hintText: 'Date of Birth',
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1920),
                          lastDate: DateTime.now());
                      //Converting to Readable Date
                      if (pickedDate != null) {
                        rawDate = pickedDate;
                        String formattedDate =
                            DateFormat("dd-MM-yyyy").format(pickedDate);
                        setState(() {
                          dateOfBirthData.text = formattedDate;
                        });
                      } else {
                        setState(() {
                          dateOfBirthData.text = "Date need to be selected";
                        });
                      }
                    },
                    validator: (value) {
                      if (rawDate == null) return "Pick your Date of Birth";
                      DateTime currentDate = DateTime.now();
                      int age = currentDate.year - rawDate!.year;
                      int cMonth = currentDate.month;
                      int bMonth = rawDate!.month;
                      if (bMonth > cMonth) {
                        age--;
                      } else if (bMonth == cMonth) {
                        int cday = currentDate.day;
                        int bday = rawDate!.day;
                        if (bday > cday) {
                          age--;
                        }
                      }
                      if (age < 18) return "You need to be legally aged";
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
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
                      ),
                    ),
                    obscureText: passwordIsNotVisible,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(400, 50),
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(fontSize: 20)),
                      onPressed: () {
                        if (_signupFormKey.currentState!.validate()) {
                          signUpHandler();
                        }
                      },
                      child: Text("Signup")),
                  const SizedBox(
                    height: 100,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text("Have an account "),
                    InkWell(
                      onTap: () => {authValueChanger.value = 0},
                      child: Text(
                        "Login ?",
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
