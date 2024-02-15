import 'package:flutter/material.dart';
import 'package:frontend/services/productSearch_filter.dart';
import 'package:provider/provider.dart';

//Screen Import
import 'package:frontend/screens/home/home.dart';
import 'package:frontend/screens/splash/splashScreen.dart';
import 'package:frontend/screens/screenMainPageController.dart';

void main() {
  runApp(LiquorApp());
}

class LiquorApp extends StatelessWidget {
  const LiquorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductSearchAndFilter())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(splashColor: Colors.lightGreen[50]),
        home: Screen_Splash(),
        routes: {
          '/entrypoint': (context) => screenController(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
