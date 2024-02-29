import 'dart:async';
import 'package:flutter/material.dart';
import 'package:namastey_india/ui/notification_permission.dart';
import 'package:namastey_india/ui/payment_mode.dart';
import 'package:namastey_india/ui/share_location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:namastey_india/Provider/UserDataStateMgmt.dart';
import 'package:namastey_india/constant/colors.dart';
import 'package:namastey_india/tabs/tabspage.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'Provider/CartDataStateMgmt.dart';
import 'ui/intro_screen.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartStateMgmt()),
        ChangeNotifierProvider(create: (context) => UserDataStateMgmt())
      ],
      child: const MaterialApp(
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin, AfterLayoutMixin<MyHomePage> {
Future checkFirstSeen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = (prefs.getBool('seen') ?? false);
  Future.delayed(const Duration(seconds: 3),() async {

    if (seen) {

      var status = await Permission.notification.status;
      if (status.isGranted) {
        print('notification permission granted');
        var status = await Permission.location.status;
        if (status.isGranted) {
          print('location permission granted');
          Get.off(
                  () => const HomePage(), //next page class
              transition: Transition.noTransition //transition effect
          );

        }else{
          Get.off(
                  () => ShareLocation(), //next page class
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              transition: Transition.zoom //transition effect
          );
        }
      }else {
        Get.off(
                () => const NotificationPermission(), //next page class
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            transition: Transition.zoom //transition effect
        );
      }
    } else {
      await prefs.setBool('seen', true);
      Get.off(
              () => IntroScreen(), //next page class
          duration: const Duration(milliseconds: 1000),
          curve: Curves.decelerate,
          transition: Transition.zoom //transition effect
      );
    }
  },);
}

@override
void afterFirstLayout(BuildContext context) => checkFirstSeen();

  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
      value: 0,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);

    _controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: colorGrey,
        primaryColor: colorOrange,
        colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: colorOrange),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            fontSize: 16,
            color: Color(0xFFB3B1B1),
          ),
          filled: true,
          fillColor: Colors.white,
          isDense: true,
        ),
        errorColor: colorOrange,
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.white,
          contentTextStyle: TextStyle(color: Colors.black),
        ),
      ),
      home: Container(
          color: Colors.white,
          child: Center(
              child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
                .animate(_controller),
            child: FadeTransition(
              opacity: _animation,
              child: SizedBox(
                width: 256,
                height: 74,
                child: Image.asset(
                  'assets/images/app_logo.png',
                ),
              ),
            ),
          ))),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabsPage(selectedIndex: 0);
  }
}
