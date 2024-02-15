import 'package:flutter/material.dart';
import 'package:frontend/screens/productDetailed/detailedProduct.dart';
import 'package:provider/provider.dart';

//////////////////////////File Import
import 'package:frontend/services/productSearch_filter.dart';

//Product Component
class ProductComponent extends StatefulWidget {
  ProductComponent({super.key});

  @override
  State<ProductComponent> createState() => ProductComponentState();
}

class ProductComponentState extends State<ProductComponent> {
  @override
  Widget build(BuildContext context) {
    //Product Data Variable
    // final productList = Provider.of<ProductSearchAndFilter>(context);

    return Container(
        color: Colors.white,
        child: Consumer<ProductSearchAndFilter>(
            builder: (context, productList, _) {
          return productList.productListToDisplay!.length > 0
              ? GridView.builder(
                  padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: productList.productListToDisplay!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailedProductView(
                                    product: productList
                                        .productListToDisplay![index])))
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.lightGreen[100],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 110,
                              width: double.infinity,
                              decoration:
                                  BoxDecoration(color: Colors.grey[200]),
                              child: Image.network(
                                productList.productListToDisplay![index]
                                    .productImageUrl![0].url!,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productList.productListToDisplay![index]
                                        .productName!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(productList
                                            .productListToDisplay![index]
                                            .category!),
                                        Row(children: [
                                          const Icon(
                                            Icons.currency_rupee,
                                            size: 20,
                                          ),
                                          Text(
                                            productList
                                                .productListToDisplay![index]
                                                .productPrice!
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ]),
                                      ])
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  margin: EdgeInsets.only(top: 120),
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mood_bad,
                          color: Colors.amber,
                          size: 50,
                        ),
                        Text(
                          "No Products Based on Filter...Try another State/Category/Search.",
                          textAlign: TextAlign.center,
                        )
                      ]),
                );
        }));
  }
}
