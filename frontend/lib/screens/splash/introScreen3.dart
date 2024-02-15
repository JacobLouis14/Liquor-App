import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///////////////////////////////FIle Import
import 'package:frontend/screens/splash/introMainScreen.dart';

class IntroScreen_3 extends StatefulWidget {
  IntroScreen_3();

  @override
  State<IntroScreen_3> createState() => _IntroScreen_3State();
}

class _IntroScreen_3State extends State<IntroScreen_3> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/Images/IntroBackgroundImage.jpg"))),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: isLegal.value == true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome",
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          fontFamily: "Italiano",
                          color: Colors.white),
                    ),
                    const Text(
                      "You are legaly aged",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          fontFamily: "Italiano",
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "It is a platform where you can find the details of your favorite brands,Filter asyou need to find the best choices...Enjoy every moments.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/entrypoint", (route) => false);
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.green,
                        ),
                        label: const Text(
                          "Let's Start",
                          style: TextStyle(color: Colors.green),
                        ))
                  ],
                )
              : const Center(
                  child: Text(
                  "Don't rush for new beginings...Come back when you are legaly older...😄",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Italiano",
                      color: Colors.white,
                      fontSize: 40,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold),
                ))),
    );
  }
}
