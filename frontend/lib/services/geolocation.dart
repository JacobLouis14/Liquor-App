// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/global/globalData.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

//////////////////////////////Global
Position? geoPosition;

////////////////////////////////////Location Permission
Future geoLocationAccess(context) async {
  bool serviceEnebled;
  LocationPermission permission;

  serviceEnebled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnebled) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location Services are disabled")));
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permissions are denied")));
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Location permissions are permanently denied, we cannot request permissions.")));
  }
  ///////////////////////////Accessing Current Raw Location
  try {
    geoPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLatitudeGlobalData = geoPosition?.latitude;
    currentLongitudeGlobalData = geoPosition?.longitude;
  } on Exception catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sorry...Error in accesing location")));
  }
}

///////////////////////////Accessing Address from Raw Location
Future getAddressFromGeoPosition(BuildContext context) async {
  try {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        geoPosition!.latitude, geoPosition!.longitude);
    Placemark place = placeMarks[0];
    stateThroughLocation = place.administrativeArea;
  } on Exception catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sorry...Error in accesing location")));
  }
}
