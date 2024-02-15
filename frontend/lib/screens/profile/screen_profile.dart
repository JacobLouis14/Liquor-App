import 'package:flutter/material.dart';
import 'package:frontend/screens/profile/admin/adminProfile.dart';
import 'package:frontend/screens/profile/user/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

/////////////////////////File Import
import 'package:frontend/models/user.dart';
import 'package:frontend/global/globalData.dart';

class ProfileScreenEntry extends StatefulWidget {
  const ProfileScreenEntry({super.key});

  @override
  State<ProfileScreenEntry> createState() => _ProfileScreenEntryState();
}

class _ProfileScreenEntryState extends State<ProfileScreenEntry> {
  //Global Variable
  late User user;

  @override
  void initState() {
    super.initState();
    user = userData!;
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences localStorage;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  user.name!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(user.isAdmin! ? "Admin" : ""),
                const SizedBox(
                  height: 20,
                ),
                user.isAdmin == true
                    ? adminProfileControls()
                    : userProfileControls(),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size(300, 50))),
                    onPressed: () async => {
                          isLogged.value = false,
                          localStorage = await SharedPreferences.getInstance(),
                          localStorage.remove('userToken'),
                          indexChanger.value = 0,
                        },
                    child: const Text("LogOut")),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
