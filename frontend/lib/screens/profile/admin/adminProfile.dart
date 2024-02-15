import 'package:flutter/material.dart';
import 'package:frontend/screens/profile/admin/widgets/category_add.dart';

//////////////////////////////File Import
import 'package:frontend/screens/profile/admin/widgets/products_add.dart';
import 'package:frontend/screens/profile/admin/widgets/state_add.dart';

class adminProfileControls extends StatefulWidget {
  const adminProfileControls({super.key});

  @override
  State<adminProfileControls> createState() => _adminProfileControlsState();
}

class _adminProfileControlsState extends State<adminProfileControls> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Divider(),
      const Text(
        "Products Management",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      adminMenuWidget(
        title: "Add Products",
        leadingIcon: Icons.add,
        onPress: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProductAdd()));
        },
      ),
      adminMenuWidget(
        title: "View Products",
        leadingIcon: Icons.view_agenda,
        onPress: () => {},
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Category Management",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      adminMenuWidget(
        title: "Add Category",
        leadingIcon: Icons.add,
        onPress: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const categoryAdd()))
        },
      ),
      adminMenuWidget(
        title: "View Category",
        leadingIcon: Icons.view_agenda,
        onPress: () => {},
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "State Management",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      adminMenuWidget(
        title: "Add State",
        leadingIcon: Icons.add,
        onPress: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const stateAdd()))
        },
      ),
      adminMenuWidget(
        title: "View State",
        leadingIcon: Icons.view_agenda,
        onPress: () => {},
      ),
      const SizedBox(
        height: 10,
      ),
    ]);
  }
}

class adminMenuWidget extends StatelessWidget {
  const adminMenuWidget({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onPress,
  });

  final String title;
  final IconData leadingIcon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.lightGreen[50]),
        child: Icon(
          leadingIcon,
          color: Colors.lightGreen[800],
        ),
      ),
      title: Text(title),
    );
  }
}
