import 'package:bookmark/model/user_model.dart' as userModel;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as gc;

class GetLocation {
  var first1;
  List<double> coordinatesPoints = [];
  LocationData? locationData;

  Future determinePosition() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("!_serviceEnabled");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("_permissionGranted != PermissionStatus.granted");
        return;
      }
    }
    // location fetching

    locationData = await location.getLocation();

    // Passed the coordinates of latitude and longitude
    coordinatesPoints.add(locationData!.longitude!);
    coordinatesPoints.add(locationData!.latitude!);
    // final coordinates =
    //     Coordinates(locationData!.latitude, locationData!.longitude);
    // var address =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
    //     import 'package:geocoding/geocoding.dart';

    List<gc.Placemark> placemarks =
        await gc.placemarkFromCoordinates(52.2165157, 6.9437819);
    // var first = address.first;
    print("placemarks = ${placemarks[0]}");
    // on below line we have set the address to string
    // return {
    //   "coordinates": coordinatesPoints,
    //   "country": "india",
    //   "state": first.adminArea.toString(),
    //   "zipcode": first.postalCode.toString(),
    //   "address1": first.locality.toString(),
    // };
  }

  // Future<userModel.Address> findAdressByPosition(
  //     double latitude, double longitude) async {
  //   final coordinates = Coordinates(latitude, longitude);
  //   var address =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);

  //   var first = address.first;
  //   List<double> coordinatesPots = [];
  //   coordinatesPots.add(first.coordinates.longitude);
  //   coordinatesPots.add(first.coordinates.latitude);
  //   // debugPrint(
  //   //     "coordinates : ${first.subAdminArea} ${first.adminArea} ${first.postalCode} looooo ${first.locality} ffffnnnn ${first.featureName} addline ${first.addressLine} subb ${first.subLocality}");
  //   return userModel.Address(
  //     id: "",
  //     city: first.locality.toString(),
  //     createdAt: "",
  //     updatedAt: "",
  //     country: "india",
  //     state: first.adminArea.toString(),
  //     zipCode: first.postalCode,
  //     addressLine1: first.addressLine.toString(),
  //   );
  // }
}
