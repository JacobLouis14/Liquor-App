import 'package:flutter/material.dart';
import 'package:frontend/global/globalData.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/services/productSearch_filter.dart';
import 'package:provider/provider.dart';

class CategoryComponent extends StatefulWidget {
  CategoryComponent({super.key});

  @override
  State<CategoryComponent> createState() => _CategoryComponentState();
}

//Global Variable
List<CategoryModel>? category;

class _CategoryComponentState extends State<CategoryComponent> {
  @override
  void initState() {
    category = categoryList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Screen properties
    var screenSize = MediaQuery.of(context).size;

    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 10, bottom: 5, left: 8),
        width: screenSize.width,
        height: screenSize.height * 0.20,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: category!.map((categoryData) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () {
                    final productFilterBasedCategory =
                        context.read<ProductSearchAndFilter>();
                    productFilterBasedCategory.productFilterBasedCategory(
                        categoryData.categoryValue!);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        foregroundImage:
                            NetworkImage(categoryData.categoryPhotoUrl!),
                      ),
                      Text(
                        categoryData.categoryName!,
                        style: const TextStyle(
                          fontFamily: 'Italiano',
                          fontSize: 35,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList()));
  }
}
