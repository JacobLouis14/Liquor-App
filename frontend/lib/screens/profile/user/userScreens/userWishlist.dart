import 'package:flutter/material.dart';

///////////////////////////////File Import
import 'package:frontend/global/globalData.dart';
import 'package:frontend/screens/productDetailed/detailedProduct.dart';
import 'package:lottie/lottie.dart';

class UserWishlist extends StatefulWidget {
  const UserWishlist({super.key});

  @override
  State<UserWishlist> createState() => _UserWishlistState();
}

class _UserWishlistState extends State<UserWishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          title: Text("WishList"),
          centerTitle: true,
        ),
        body: wishListProductData!.length > 0
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ListView(
                  children: wishListProductData!
                      .where((wishElement) => productDataList!.any(
                          (productElement) =>
                              wishElement == productElement.pId))
                      .map((filteredWishElement) {
                    // Find the product in productDataList that matches the filteredWishElement
                    var matchingProduct = productDataList!.firstWhere(
                        (productElement) =>
                            productElement.pId == filteredWishElement);

                    // You can now use the details of the matching product
                    return Column(children: [
                      ListTile(
                        horizontalTitleGap: 5,
                        visualDensity: VisualDensity(vertical: 4),
                        title: Text(matchingProduct.productName!),
                        trailing: const Icon(Icons.arrow_right),
                        leading: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              matchingProduct.productImageUrl![0].url!),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailedProductView(
                                      product: matchingProduct)));
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ]);
                  }).toList(),
                ))
            : Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.network(
                        "https://lottie.host/705a5c28-c7c6-414f-b019-e52b2d388f28/zlis3RQ9Et.json"),
                    Text("Not added any")
                  ],
                )));
  }
}
