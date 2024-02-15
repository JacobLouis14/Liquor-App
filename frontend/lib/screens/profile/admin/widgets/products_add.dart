import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

//Global Data
List categoryList = ['Rum', 'Brandy'];
String selectedCategory = '';
List stateList = ['Kerala', 'Tamil Nadu'];
String selectedState = '';

//Form Key
final addProductFormKey = GlobalKey<FormState>();

class _ProductAddState extends State<ProductAdd> {
//Image adding Service
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imagesList = [];
  void addProductImage() async {
    try {
      final List<XFile> selectedImage = await imagePicker.pickMultiImage();
      if (selectedImage.isNotEmpty) {
        setState(() {
          imagesList!.addAll(selectedImage);
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          "Add Product",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Form(
            key: addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Product Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Product Price',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Product Code',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Brand Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Quantity',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Proof',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'EDP',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButton<String>(
                    hint: selectedCategory != ""
                        ? Text(selectedCategory)
                        : Text("Select category"),
                    items: categoryList.map((value) {
                      return DropdownMenuItem<String>(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    isExpanded: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButton<String>(
                    hint: selectedState != ""
                        ? Text(selectedState)
                        : Text("Select state where it belongs"),
                    items: stateList.map((value) {
                      return DropdownMenuItem<String>(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedState = value!;
                      });
                    },
                    isExpanded: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (imagesList!.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: imagesList!.length,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 5),
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                Image.file(
                                  File(imagesList![index].path),
                                ),
                                Positioned(
                                    top: 3,
                                    right: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.lightGreen),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            imagesList?.removeAt(index);
                                          });
                                        },
                                        child: Icon(Icons.close),
                                      ),
                                    ))
                              ]),
                            );
                          }),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: addProductImage,
                      child: const Text("Add Image")),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.lightGreen),
                          minimumSize: MaterialStatePropertyAll(Size(400, 50))),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Add Product",
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
      )),
    );
  }
}
