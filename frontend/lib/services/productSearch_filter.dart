import 'package:flutter/material.dart';
import 'package:frontend/global/globalData.dart';
import 'package:frontend/models/product.dart';

class ProductSearchAndFilter extends ChangeNotifier {
//Product To Display
  List<ProductModel>? productListToDisplay;

  //Search Services
  void productSearchService(String searchValue) {
    if (searchValue.isEmpty) {
      productListToDisplay = productDataList!;
      notifyListeners();
    } else {
      productListToDisplay = productDataList!
          .where((element) =>
              element.productValue!.contains(searchValue.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

  //Category Services
  void productFilterBasedCategory(String categoryValue) {
    if (categoryValue.isEmpty) {
      productListToDisplay = productDataList;
      notifyListeners();
    } else {
      productListToDisplay = productDataList!
          .where((element) =>
              element.category!.toLowerCase() == categoryValue.toLowerCase())
          .toList();
      notifyListeners();
    }
  }

  //State Location Filter Products
  void productFilterBasedState(String? stateValue) {
    if (stateValue == null) {
      productListToDisplay = productDataList;
      //Future.microtask((){}) schedules the notifyListeners to be called in the next microtask,
      //allowing the current build phase to complete.
      Future.microtask(() {
        notifyListeners();
      });
    } else {
      productListToDisplay = productDataList!
          .where(
              (element) => element.productAvailableState!.contains(stateValue))
          .toList();
      Future.microtask(() {
        notifyListeners();
      });
    }
  }
}
