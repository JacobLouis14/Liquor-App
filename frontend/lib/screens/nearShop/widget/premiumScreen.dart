// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/services/geolocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

///////////////////////////////////File Import
import 'package:frontend/global/globalData.dart';
import 'package:frontend/models/shop.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  List<ShopModel>? premiumShopList;

  void premiumShopListCheckUp() async {
    //Checking Cordinates available
    await geoLocationAccess(context);
    setState(() {
      premiumShopList = shopListData!
          .where((element) => element.category!.toLowerCase() == "premium")
          .toList();
      //Adding Arieal Distance Property Value
      if (currentLatitudeGlobalData != null &&
          currentLongitudeGlobalData != null) {
        premiumShopList = premiumShopList!.map((shop) {
          shop.ariealDistance =
              ariealDistanceHandler(shop.latitude!, shop.longitude!);
          return shop;
        }).toList();
        //Sorting acending based on Arieal distance
        premiumShopList!
            .sort((a, b) => a.ariealDistance!.compareTo(b.ariealDistance!));
      }
    });
  }

  //Arieal Distance Handler
  double ariealDistanceHandler(double desLatitude, double desLongitude) {
    return Geolocator.distanceBetween(currentLatitudeGlobalData!,
            currentLongitudeGlobalData!, desLatitude, desLongitude) /
        1000;
  }

  // google map direction handler
  void directionHandler(ShopModel shop) async {
    final Uri mapUrl = Uri.parse(
        "https://www.google.com/maps/dir/?api=1&origin=$currentLatitudeGlobalData%2C$currentLongitudeGlobalData&destination=${shop.latitude}%2C${shop.longitude}&travelmode=driving");
    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Sorry...Error in opening maps. Try later")));
    }
  }

  @override
  void initState() {
    premiumShopListCheckUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (premiumShopList != null) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
          child: premiumShopList!.isNotEmpty
              ? Column(
                  children: premiumShopList!.map((shop) {
                    return ListTile(
                      onTap: () async {
                        if (currentLatitudeGlobalData != null &&
                            currentLongitudeGlobalData != null) {
                          directionHandler(shop);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "We need location access. Try again")));
                        }
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.lightGreen[400],
                        child: const Icon(
                          Icons.store,
                          size: 40,
                        ),
                      ),
                      title: Text(
                        shop.name!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(shop.address!),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(shop.ariealDistance != null
                              ? shop.ariealDistance!.toStringAsFixed(3)
                              : "Not Available"),
                          const Text(
                            "Km",
                            style: TextStyle(letterSpacing: 1, fontSize: 12),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.network(
                        "https://lottie.host/705a5c28-c7c6-414f-b019-e52b2d388f28/zlis3RQ9Et.json"),
                    const Text("Not Found.Try Again Later")
                  ],
                ));
    }
    return Center(
        child: Lottie.network(
            "https://lottie.host/b3d63aff-e5d2-4562-82e7-3f9b2f75d345/u2ZQIbvZfS.json",
            height: 200,
            width: 200));
  }
}
