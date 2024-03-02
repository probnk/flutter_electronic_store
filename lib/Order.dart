import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:electronic_store_app/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';


class OrderDone extends StatelessWidget {
  const OrderDone({super.key});

  DoneScreen() {
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
              child: Column(
                children: [
                  Lottie.asset('assets/PaymentDone.json',),
                  Center(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText(
                          'Payment Done Successfully',
                          textAlign: TextAlign.center,
                          textStyle: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      ],

                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  )
                  ],
              )
            ),
            duration: 900,
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType:PageTransitionType.fade,
            curve: Curves.bounceInOut,
            animationDuration: Duration(seconds: 1),
            splashIconSize: 400,
            nextScreen: BottomNavBar()
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DoneScreen();
  }
}
