import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:namastey_india/ui/share_location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:notification_permissions/notification_permissions.dart';

import '../constant/colors.dart';
import '../tabs/tabspage.dart';

const Color accentPurpleColor = Color(0xFF6A53A1);
const Color accentPinkColor = Color(0xFFF99BBD);
const Color accentDarkGreenColor = Color(0xFF115C49);
const Color accentYellowColor = Color(0xFFFFB612);
const Color accentOrangeColor = Color(0xFFEA7A3B);

class NotificationPermission extends StatelessWidget {
  const NotificationPermission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontWidth = MediaQuery.of(context).size.width;
    double fontHeight = MediaQuery.of(context).size.height;
    return Scaffold(

        backgroundColor: colorOrange,
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
                  'assets/images/ic_notification.svg',
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Allow Notifications",
                  style: TextStyle(
                      color: Colors.white, fontSize: fontWidth * 0.06,fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: fontWidth * 0.03,
                      left: fontWidth * 0.1,
                      right: fontWidth * 0.1),
                  child: Center(
                    child: Text(
                      "Stay updated with our updates and notifications all the time",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontSize: fontWidth * 0.04),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                GestureDetector(
                    onTap: () {
                        getNotificationPermission(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.all(14),
                      child: const Center(
                          child: Text(
                            "Notifiy Me",
                            style: TextStyle(color: Colors.orange,fontSize: 17,fontWeight: FontWeight.bold),
                          )),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white),

                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => ShareLocation()),
                    );
                  },
                  child: const Padding(
                      padding: EdgeInsets.fromLTRB(15,10,0,24),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "skip",
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

  Future<void> getNotificationPermission(BuildContext context) async {
    // await Permission.notification.request();

    var status = await Permission.notification.status;
    if (status.isGranted) {
      print('notification permission granted');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ShareLocation()),
      );

    } else if (status.isDenied) {
      print('notification permission denied');
      await [ Permission.notification, ].request();
      getNotificationPermission(context);

    } else if (status.isPermanentlyDenied || status.isRestricted) {
      print('notification permission permanently denied');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Notifications denied :("),
              titleTextStyle:
              const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,fontSize: 20),
              content: const Text("Enable notification permission from system app settings."),
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
}
