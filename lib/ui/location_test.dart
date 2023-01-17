import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:namastey_india/constant/colors.dart';
import 'package:permission_handler/permission_handler.dart';

void main(){
  runApp(MaterialApp(home: MyAppLocTest(),));
}
class MyAppLocTest extends StatefulWidget {
  @override
  _MyAppLocTestState createState() => _MyAppLocTestState();
}

class _MyAppLocTestState extends State<MyAppLocTest> {

  final geoLocator = Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  late Position _currentPosition;

  String ca = "Your location will be viewed here!";

  Future<void> getNotificationPermission() async {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  Future<void> getLocationPermission() async {
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      print('location services enabled');

      var status = await Permission.location.status;
      if (status.isGranted) {
        print('location permission granted');

        getCurrentLocation();

        } else if (status.isDenied) {
        print('location permission denied');
        await [ Permission.location, ].request();

      } else if (status.isPermanentlyDenied || status.isRestricted) {
        print('location permission permanently denied');
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Location denied :("),
                titleTextStyle:
                const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,fontSize: 20),
                content: const Text("Enable location permission from system app settings."),
                actionsOverflowButtonSpacing: 20,
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text("Cancel",style: TextStyle(color: colorBlue),),
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      )),
                  ElevatedButton(onPressed: (){
                    openAppSettings();
                  }, child: const Text("Open Settings"),
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(colorOrange),
                      )),
                ],
              );
            });
      }
    }
    else{
      print('location services disabled');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Enable location"),
              titleTextStyle:
              const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,fontSize: 20),
              content: const Text("Please enable location services!"),
              actionsOverflowButtonSpacing: 20,
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("Close",style: TextStyle(color: colorBlue),),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    )),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                  getLocationPermission();
                }, child: const Text("Retry"),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(colorOrange),
                    )),
              ],
            );
          });
    }
  }

  Future<void> getCurrentLocation() async {

    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  void getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        ca =
            "name - ${place.name},        "
            "        street - ${place.street},        "
            "        isoCountryCode - ${place.isoCountryCode},        "
            "        country - ${place.country},        "
            "        postalCode - ${place.postalCode},        "
            "        administrativeArea - ${place.administrativeArea},        "
            "        subAdministrativeArea - ${place.subAdministrativeArea},        "
            "        locality - ${place.locality},        "
            "        subLocality - ${place.subLocality},        "
            "        thoroughfare - ${place.thoroughfare},        "
            "        subThoroughfare - ${place.subThoroughfare},"
            ;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Location"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                    color: Colors.red,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        ca.toString(),
                        style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                        ),
                      ),
                    ),
                  )
              ),

              Container(
                height: 100,
                width: double.infinity,
                color: Colors.blue,
                child: ElevatedButton(
                  child: const Text(
                    'Get Location',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white
                    )
                  ),
                  onPressed:(){
                    getLocationPermission();
                  },
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}