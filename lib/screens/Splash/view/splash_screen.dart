import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../app/routes/routes.dart';
import '../../../helper/GetStorageHelper.dart';
import '../../../services/notifications/pushNotifications.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      // Initialize push notifications
      PushNotifications.init();
      PushNotifications.firebaseInitial();
      PushNotifications.isTokenRefreshed();

      // Set initial data using GetStorageHelper
      GetStorageHelper.setinitialdata();
      // Retrieve login status from GetStorage
      bool? isLoggedIn = box.read("is_logged_raipurHome");
      print("is loggedin=====> $isLoggedIn");
      // Set a timer to navigate to the appropriate screen after a delay
      _timer = Timer(
        const Duration(seconds: 1),
        () {
          if (isLoggedIn == true) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.homeMain,
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.onBoarding,
              (route) => false,
            );
          }
        },
      );
    }
  }

  @override
  void dispose() {
    // Cancel the timer to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: FadeInUp(
                  curve: Curves.bounceInOut,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: const DecorationImage(
                            image: AssetImage("assets/png/rprNewLogo.png"),
                            fit: BoxFit.fill)),
                  ),
                ),
              )),
        ],
      ),
    ));
  }
}
