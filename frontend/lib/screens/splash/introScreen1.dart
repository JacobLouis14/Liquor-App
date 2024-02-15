import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/Auth/ScreenAuth.dart';

class IntroScreen_1 extends StatefulWidget {
  final PageController controller;
  const IntroScreen_1({required this.controller});

  @override
  State<IntroScreen_1> createState() => _IntroScreen_1State();
}

class _IntroScreen_1State extends State<IntroScreen_1>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Do you want to Register/Login now ?",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Italiano",
              fontSize: 40,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton.icon(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScreenAuthMain()));
              },
              icon: const Icon(
                Icons.thumb_up,
                color: Colors.black,
              ),
              label: const Text(
                "Login/Register",
                style: TextStyle(color: Colors.black),
              )),
          const SizedBox(
            height: 230,
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                      onPressed: () {
                        widget.controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      icon: const Icon(Icons.chevron_right)),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
