import 'package:flutter/material.dart';

///////////////////////////////////File Import
import 'package:frontend/screens/nearShop/widget/ordinaryScreen.dart';
import 'package:frontend/screens/nearShop/widget/premiumScreen.dart';

class Screen_nearShop_mainScreen extends StatefulWidget {
  const Screen_nearShop_mainScreen({super.key});

  @override
  State<Screen_nearShop_mainScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Screen_nearShop_mainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Near Shops"),
          centerTitle: true,
          bottom: const TabBar(tabs: [Text("Ordinary"), Text("Premium")]),
        ),
        body: const TabBarView(children: [OrdinaryScreen(), PremiumScreen()]),
      ),
    );
  }
}
