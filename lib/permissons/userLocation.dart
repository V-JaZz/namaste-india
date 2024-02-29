import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


class UserLocation {
  final BuildContext context;
  UserLocation(this.context);

  final geoLocator = Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  late Position currentPosition;

  Future<Placemark?> getLocation() async {
    Placemark? userAddress;
    String currentFullAddress;

    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      print('location services enabled');

      var status = await Permission.location.status;
      if (status.isGranted) {
        print('location permission granted');


        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
            .then((Position position) async {

          currentPosition = position;
          try {

             List<Placemark> p = await placemarkFromCoordinates(
                currentPosition.latitude, currentPosition.longitude);

            userAddress = p[0];
            currentFullAddress =
            "name - ${userAddress!.name},        "
                "        street - ${userAddress!.street},        "
                "        isoCountryCode - ${userAddress!.isoCountryCode},        "
                "        country - ${userAddress!.country},        "
                "        postalCode - ${userAddress!.postalCode},        "
                "        administrativeArea - ${userAddress!.administrativeArea},        "
                "        subAdministrativeArea - ${userAddress!.subAdministrativeArea},        "
                "        locality - ${userAddress!.locality},        "
                "        subLocality - ${userAddress!.subLocality},        "
                "        thoroughfare - ${userAddress!.thoroughfare},        "
                "        subThoroughfare - ${userAddress!.subThoroughfare},"
            ;
          } catch (e) {
            print(e);
          }
        }).catchError((e) {
          print(e);
        });
      } else if (status.isDenied) {
        print('location permission denied');

      } else if (status.isPermanentlyDenied || status.isRestricted) {
        print('location permission permanently denied');
      }
    }
    else{
      print('location services disabled');
    }
    return userAddress;
  }
}