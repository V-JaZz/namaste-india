import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:get/get.dart';
import 'package:namastey_india/constant/colors.dart';

import 'notification_permission.dart';

class IntroScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: OnBoard(
          pageController: _pageController,
          // Either Provide onSkip Callback or skipButton Widget to handle skip state
          onSkip: () {
            // print('skipped');
          },
          // Either Provide onDone Callback or nextButton Widget to handle done state
          onDone: () {
            // print('done tapped');
          },
          imageHeight: 230,
          imageWidth: 230,
          onBoardData: onBoardData,
          titleStyles: const TextStyle(
            color: Colors.deepOrange,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
          descriptionStyles: const TextStyle(
            fontSize: 16,
            color: Colors.black45,
          ),
          pageIndicatorStyle: const PageIndicatorStyle(
            width: 100,
            inactiveColor: Color(0XFFC4C4C4),
            activeColor: Colors.deepOrange,
            inactiveSize: Size(8, 8),
            activeSize: Size(12, 12),
          ),
          // Either Provide onSkip Callback or skipButton Widget to handle skip state
          skipButton:
          Container() /*TextButton(
            onPressed: () {
              // print('skipButton pressed');
            },
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.deepOrangeAccent),
            ),
          )*/
          ,
          // Either Provide onDone Callback or nextButton Widget to handle done state
          nextButton: GestureDetector(
            onTap: () {
              Get.off(
                      () => const NotificationPermission(), //next page class
                  duration: const Duration(milliseconds: 800),
                  transition: Transition.native //transition effect
              );
            },
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: colorOrange),
              child: const Text(
                "Get Started" /*state.isLastPage ? "Done" : "Next"*/,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Set Location",
    description:
        "Stay home, Stay safe. We’ll pick the lab samples from your home itself",
    imgUrl: "assets/images/intro1.png",
  ),
  const OnBoardModel(
    title: "Select Food & Order",
    description:
        "Stay home, Stay safe. We’ll pick the lab samples from your home itself",
    imgUrl: 'assets/images/intro2.png',
  ),
  const OnBoardModel(
    title: "Fast Deliver",
    description:
        "Stay home, Stay safe. We’ll pick the lab samples from your home itself",
    imgUrl: 'assets/images/intro3.png',
  ),
];
