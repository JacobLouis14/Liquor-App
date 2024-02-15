// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/////////////////////////////////File Import
import 'package:frontend/models/product.dart';
import 'package:frontend/global/globalData.dart';

// ignore: must_be_immutable
class DetailedProductView extends StatefulWidget {
  DetailedProductView({required this.product});
  ProductModel product;

  @override
  State<DetailedProductView> createState() => _DetailedProductViewState();
}

class _DetailedProductViewState extends State<DetailedProductView> {
  bool isWishlisted = false;
  bool isWishlistEngaed = false;

  @override
  void initState() {
    for (var element in wishListProductData!) {
      if (element == widget.product.pId) {
        isWishlisted = true;
      }
    }
    super.initState();
  }

  //Handling WishList Function
  void whishListHandler() {
    setState(() {
      isWishlisted = !isWishlisted;
    });
    if (isWishlisted == true) {
      wishListProductData!.add(widget.product.pId!);
    } else {
      wishListProductData!.remove(widget.product.pId);
    }
  }

  //Handling Wishlist Api
  Future<void> wishlistApiHandler() async {
    try {
      if (isWishlistEngaed == true) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        String? userToken = localStorage.getString('userToken');
        var response = await http.patch(
            Uri.parse("http://192.168.0.10:5000/users/createwishlist"),
            headers: {
              "Authorization": "Bearer $userToken",
              "content-type": "application/json; charset=UTF-8",
              "Connection": "keep-alive",
              "Accept": "*/*"
            },
            body: jsonEncode({"wishlistData": wishListProductData}));
        if (response.statusCode != 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              showCloseIcon: true,
              content: Text("Error in Wishlist addition")));
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        await wishlistApiHandler();
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Stack(children: [
                Container(
                  height: 350,
                  child: Image.network(
                    widget.product.productImageUrl![0].url!,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back)),
                ),
              ]),
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Text(
                  widget.product.productName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      fontFamily: "Italiano"),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Product Details",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          title: Text("Brand Name"),
                          trailing: Text(
                            widget.product.brandName!,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        ListTile(
                          title: Text("Quantity"),
                          trailing: Text(
                            widget.product.quantity!.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        ListTile(
                          title: Text("Proof"),
                          trailing: Text(
                            widget.product.proof!.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        ListTile(
                          title: Text("EDP"),
                          trailing: Text(
                            widget.product.eDP!.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        ListTile(
                          title: Text("Category"),
                          trailing: Text(
                            widget.product.category!,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Container(
                color: Colors.lightGreen[100],
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Price: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "₹ ${widget.product.productPrice}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        isWishlistEngaed = true;
                        whishListHandler();
                        if (isWishlisted != true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  showCloseIcon: true,
                                  content: Text("Wishlist removed")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  showCloseIcon: true,
                                  content: Text("Wishlist added")));
                        }
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: isWishlisted ? Colors.red : Colors.black,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
