import 'package:flutter/material.dart';

//File Import
import 'package:frontend/global/globalData.dart';
import 'package:frontend/screens/Auth/widget/Login.dart';
import 'package:frontend/screens/Auth/widget/Signup.dart';

class ScreenAuthMain extends StatefulWidget {
  const ScreenAuthMain({super.key});

  @override
  State<ScreenAuthMain> createState() => _ScreenAuthMainState();
}

class _ScreenAuthMainState extends State<ScreenAuthMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
              child: ValueListenableBuilder(
            valueListenable: authValueChanger,
            builder: (context, int value, _) {
              return value == 0 ? Login() : SignUp();
            },
          )),
        ),
      ),
    );
  }
}
