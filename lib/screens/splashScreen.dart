import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:book_worm/widgets/bookWormLogo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:book_worm/functions/postApiCalls.dart';
import 'package:book_worm/navigationBar.dart';
import 'package:book_worm/screens/authentication/entryPointScreen.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  Future<Widget> loadFromFuture() async {
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          isLoggedIn = false;
        });
      } else {
        print('User is signed in!');
        setState(() {
        isLoggedIn = true;
        });
      }
    });
    return isLoggedIn
        ? Future.value(NavigationBarScreen())
        : Future.value(EntryPointScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: AnimatedSplashScreen.withScreenFunction(
        backgroundColor: Colors.transparent,
        splash: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/Logo.png',
                height: 10.h,),
              BookWormLogo(fontSize: 35.sp),
            ],
          ),
        ),
        splashIconSize: 75.w,
        screenFunction: () async {
          return loadFromFuture();
        },
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}
