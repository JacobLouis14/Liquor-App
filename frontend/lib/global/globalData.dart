import 'package:flutter/material.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/shop.dart';
import 'package:frontend/models/state.dart';
import 'package:frontend/models/user.dart';

//Update the bottomNavBar index value
ValueNotifier<int> indexChanger = ValueNotifier(0);

//Auth Login / SignUp value changer
ValueNotifier<int> authValueChanger = ValueNotifier(0);

//Variable to know logged in
ValueNotifier<bool> isLogged = ValueNotifier(false);

//User Data
User? userData;

//State List
List<StateModel>? stateList;

//Shop List
List<ShopModel>? shopListData;

//State through Location
String? stateThroughLocation;

//Users current latitude and Longitude
double? currentLatitudeGlobalData;
double? currentLongitudeGlobalData;

//Global Product List
List<ProductModel>? productDataList;

//apps first run
bool isInitialRun = true;

/////////////////////////////Screen->home->header widget global variable///////////////////////////
String? selectedLocation = "Select Location";
List<StateModel>? location;
var isSelectedIndex = null;

/////////////////////////////Screen->home->category widget global variable///////////////////////////
List<CategoryModel>? categoryList;

////////////////////////////Screen->ProductDetailed->global variable/////////////////////////////////
List<String>? wishListProductData = [];
