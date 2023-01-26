import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:kimber/functions/postApiCalls.dart';
import 'package:kimber/navigationBar.dart';
import 'package:kimber/screens/authentication/entryPointScreen.dart';
import 'package:kimber/utils/colors.dart';
import 'package:kimber/widgets/kimberLogo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PostApiCalls postApiCalls = new PostApiCalls();

  isUserLoggedIn() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    return status;
  }

  Future<Widget> loadFromFuture() async {
    var state = await isUserLoggedIn();
    if(state == false){
      return Future.value(EntryPointScreen());
    }
    else{
    var api1 = postApiCalls.getAllPosts();
    var list = await api1;
    return Future.value(EntryPointScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: AnimatedSplashScreen.withScreenFunction(
        backgroundColor: Colors.transparent,
        splash: Center(
          child: KimberLogo(fontSize: 35.sp),
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
