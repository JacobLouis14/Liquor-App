import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/splash/introScreen1.dart';
import 'package:frontend/screens/splash/introScreen2.dart';

//isLegal Value change notifier
ValueNotifier isLegal = ValueNotifier(false);
ValueNotifier<bool> isEngaged = ValueNotifier(false);

class IntroScreenMain extends StatefulWidget {
  const IntroScreenMain({super.key});

  @override
  State<IntroScreenMain> createState() => _IntroScreenMainState();
}

class _IntroScreenMainState extends State<IntroScreenMain>
    with TickerProviderStateMixin {
  Future<void> loadImage(String imageUrl) async {
    try {
      await precacheImage(AssetImage(imageUrl), context);
    } on Exception catch (e) {
      print("Error in loadImage ${e}");
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    loadImage("assets/Images/IntroBackgroundImage.jpg");
    super.didChangeDependencies();
  }

  ///Page Controller
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
          future: precacheImage(
              AssetImage("assets/Images/IntroBackgroundImage.jpg"), context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            "assets/Images/IntroBackgroundImage.jpg"))),
                child: Stack(
                  children: [
                    PageView(controller: _controller, children: [
                      IntroScreen_1(
                        controller: _controller,
                      ),
                      IntroScreen_2(
                        controller: _controller,
                      ),
                    ]),
                  ],
                ),
              );
            }
          }),
    );
  }
}
