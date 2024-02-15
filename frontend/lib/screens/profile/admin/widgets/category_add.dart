import 'package:flutter/material.dart';

class categoryAdd extends StatefulWidget {
  const categoryAdd({super.key});

  @override
  State<categoryAdd> createState() => _categoryAddState();
}

//Form Key
final categoryFormKey = GlobalKey<FormState>();

class _categoryAddState extends State<categoryAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Add Category",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: categoryFormKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                decoration:
                    const InputDecoration(hintText: "Name new Category"),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                  style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size(400, 50)),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.lightGreen)),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Add Category",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
