import 'package:flutter/material.dart';

//File Import
import 'package:frontend/global/globalData.dart';
import 'package:frontend/screens/Auth/ScreenAuth.dart';
import 'package:frontend/screens/commonWidget/bottomNavBar.dart';
import 'package:frontend/screens/home/home.dart';
import 'package:frontend/screens/nearShop/screen_nearShop.dart';
import 'package:frontend/screens/profile/screen_profile.dart';

class screenController extends StatefulWidget {
  const screenController({super.key});

  @override
  State<screenController> createState() => _screenControllerState();
}

const screens = [HomeScreen(), Screen_nearShop_mainScreen(), ScreenAuthMain()];

class _screenControllerState extends State<screenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
          valueListenable: indexChanger,
          builder: (context, int index, _) {
            if (index == 2 && isLogged.value) {
              return ProfileScreenEntry();
            } else {
              return screens[index];
            }
          },
        ),
        bottomNavigationBar: bottomNavigationBar());
  }
}
