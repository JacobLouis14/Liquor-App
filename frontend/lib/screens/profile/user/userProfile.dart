import 'package:flutter/material.dart';
import 'package:frontend/screens/profile/user/userScreens/userWishlist.dart';

class userProfileControls extends StatelessWidget {
  const userProfileControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          shape: Border(bottom: BorderSide(width: 20, color: Colors.black)),
          leading: Icon(Icons.shopping_bag),
          title: Text("Wishlist"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserWishlist()))
          },
        ));
  }
}
