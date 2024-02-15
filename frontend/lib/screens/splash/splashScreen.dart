// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

/////////////////////File Import
import 'package:frontend/screens/splash/introMainScreen.dart';
import 'package:frontend/global/globalData.dart';
import 'package:frontend/services/category.dart';
import 'package:frontend/services/check_user.dart';
import 'package:frontend/services/geolocation.dart';
import 'package:frontend/services/product.dart';
import 'package:frontend/services/shop_list.dart';
import 'package:frontend/services/state_location.dart';

class Screen_Splash extends StatefulWidget {
  const Screen_Splash({super.key});

  @override
  State<Screen_Splash> createState() => _Screen_SplashState();
}

class _Screen_SplashState extends State<Screen_Splash>
    with TickerProviderStateMixin {
//Intial Apis loading function
  void initialApis() async {
    await checkUserLoggedIn(context);
    await stateLocation(context);
    await geoLocationAccess(context);
    if (currentLatitudeGlobalData != null &&
        currentLongitudeGlobalData != null) {
      await getAddressFromGeoPosition(context);
    }
    await getProductDetails();
    await getCategory(context);
    await getShopList(context);
    if (userData == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IntroScreenMain()));
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/entrypoint", (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    initialApis();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                // Colors.green.shade900, Colors.grey.shade400
                colors: [
              Colors.lightGreen.shade900,
              Colors.greenAccent.shade100
            ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Text(
              "Cheers",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Italiano'),
            ),
            Positioned(
                bottom: 50,
                child: Lottie.network(
                    "https://lottie.host/b3d63aff-e5d2-4562-82e7-3f9b2f75d345/u2ZQIbvZfS.json",
                    height: 200,
                    width: 200)),
          ],
        ),
      ),
    );
  }
}
