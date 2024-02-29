import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:namastey_india/ui/pnone_number.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constant/colors.dart';

class ShareLocation extends StatefulWidget {
  @override
  _ShareLocationState createState() => _ShareLocationState();
}

class _ShareLocationState extends State<ShareLocation> {
  @override
  Widget build(BuildContext context) {
    double fontWidth = MediaQuery.of(context).size.width;
    double fontHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: colorBlue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: fontHeight * 0.4,
                ),
                SvgPicture.asset(
                  'assets/images/ic_location.svg',
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Share The Location",
                  style: TextStyle(
                      color: Colors.white, fontSize: fontWidth * 0.06,fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: fontWidth * 0.03,
                      left: fontWidth * 0.1,
                      right: fontWidth * 0.1),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Before you continue, we need to access your location so as to find the Food near you",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontSize: fontWidth * 0.04),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                      getLocationPermission(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white),
                    child: const Center(
                        child: Text(
                          "Allow Location",
                          style: TextStyle(color: colorBlue, fontSize: 16,fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.off(
                            () => MyPhonePage(), //next page class
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.decelerate,
                        transition: Transition.rightToLeft //transition effect
                    );
                  },
                  child: const Padding(
                      padding: EdgeInsets.fromLTRB(18,15,0,30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Or continue without set Location",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white),
                        ),
                      )),
                )
              ],
            )
          ],
        ));
  }


  Future<void> getLocationPermission(BuildContext context) async {
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      print('location services enabled');

      var status = await Permission.location.status;
      if (status.isGranted) {
        print('location permission granted');

        Get.off(
                () => MyPhonePage(), //next page class
            duration: const Duration(milliseconds: 1000),
            curve: Curves.decelerate,
            transition: Transition.rightToLeft //transition effect
        );

      } else if (status.isDenied) {
        print('location permission denied');
        await [ Permission.location, ].request();

        for(int i=0; i<5; i++ ){

        }

        var status = await Permission.location.status;
        if (status.isGranted) {
          print('location permission granted');

          Get.off(
                  () => MyPhonePage(), //next page class
              duration: const Duration(milliseconds: 1000),
              curve: Curves.decelerate,
              transition: Transition.rightToLeft //transition effect
          );
        }

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
                  },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      ), child: const Text("Cancel",style: TextStyle(color: colorBlue),)),
                  ElevatedButton(onPressed: (){
                    openAppSettings();
                  },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(colorOrange),
                      ), child: const Text("Open Settings")),
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
                },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ), child: const Text("Close",style: TextStyle(color: colorBlue),)),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                  getLocationPermission(context);
                },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(colorOrange),
                    ), child: const Text("Retry")),
              ],
            );
          });
    }
  }
}
