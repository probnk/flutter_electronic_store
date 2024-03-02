import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:electronic_store_app/getStarted.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Screen() {
    return Container(
      decoration:  BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade500,Colors.purple.shade500])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedSplashScreen(
            backgroundColor: Colors.transparent,
            splash: Center(
              child: Lottie.asset('assets/ecommerce logo.json',),
            ),
            duration: 2000,
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType:PageTransitionType.fade,
            curve: Curves.bounceInOut,
            animationDuration: Duration(seconds: 1),
            splashIconSize: 400,
            nextScreen: GetStarted()
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen();
  }
}
