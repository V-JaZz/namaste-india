import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namastey_india/Provider/UserDataStateMgmt.dart';
import 'package:namastey_india/constant/colors.dart';
import 'package:namastey_india/models/userLoginDataModel.dart';
import 'package:namastey_india/tabs/tabspage.dart';
import 'package:provider/provider.dart';
import 'Provider/CartDataStateMgmt.dart';
import 'ui/intro_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
      value: 0,
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.ease);

    _controller.forward();

    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => IntroScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
            child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
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
        )));
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HomePage extends StatelessWidget {
  UserData? userData;
  HomePage({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartStateMgmt()),
        ChangeNotifierProvider(create: (context) => UserDataStateMgmt())
      ],
      child: MaterialApp(
        theme: ThemeData(
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
              backgroundColor: Colors.white, actionTextColor: colorBlue),
        ),
        home: TabsPage(selectedIndex: 0, userData: userData),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
