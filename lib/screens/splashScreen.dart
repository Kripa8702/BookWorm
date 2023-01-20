import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:kimber/functions/postApiCalls.dart';
import 'package:kimber/navigationBar.dart';
import 'package:kimber/utils/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PostApiCalls postApiCalls = new PostApiCalls();

  Future<Widget> loadFromFuture() async {
    // var state = await isUserLoggedIn();
    // if(status == false){
    //   return Future.value(LoginOrSignUpScreen(route: '/home'));
    // }
    // else{
    var api1 = postApiCalls.getAllPosts();
    // var api2 = getProductOffers();
    // var api3 = getAllProducts();
    var list = await api1;
    // // productCartList = await getCartProducts();
    // productOffers = await api2;
    // productOffers = await api3;
    return Future.value(NavigationBarScreen());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          blue,
          yellowAccent2,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedSplashScreen.withScreenFunction(
          backgroundColor: Colors.transparent,
          splash: Center(
            child: Text(
              'Kimber',
              style: TextStyle(fontSize: 35.sp),
            ),
          ),
          splashIconSize: 75.w,
          screenFunction: () async {
            return loadFromFuture();
          },
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        ),
      ),
    );
  }
}
