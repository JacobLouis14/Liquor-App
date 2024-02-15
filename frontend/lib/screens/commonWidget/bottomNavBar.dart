import 'package:flutter/material.dart';
import 'package:frontend/global/globalData.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({super.key});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
// Tapped Function
  void selectedIndex(int index) {
    setState(() {
      indexChanger.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        // index listner
        valueListenable: indexChanger,
        builder: (context, int newIndex, _) {
          return ValueListenableBuilder(
              // user logged listner
              valueListenable: isLogged,
              builder: (context, bool logged, _) {
                return BottomNavigationBar(
                  selectedItemColor: Colors.lightGreen[900],
                  items: [
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_basket_rounded),
                        label: 'Near Shop'),
                    BottomNavigationBarItem(
                        icon: Icon(logged ? Icons.person : Icons.login_rounded),
                        label: logged ? "Profile" : 'Login'),
                  ],
                  currentIndex: newIndex,
                  onTap: selectedIndex,
                );
              });
        });
  }
}
