import 'package:flutter/material.dart';

//widgets
import 'package:frontend/screens/home/widgets/category.dart';
import 'package:frontend/screens/home/widgets/header.dart';
import 'package:frontend/screens/home/widgets/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), //Unfocus on tap
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                HeaderComponent(),
                CategoryComponent(),
                ProductComponent()
              ],
            ),
          );
        }),
      ),
    );
  }
}
