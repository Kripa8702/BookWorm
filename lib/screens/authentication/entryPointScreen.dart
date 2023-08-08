import 'package:flutter/material.dart';
import 'package:book_worm/screens/authentication/loginScreen.dart';
import 'package:book_worm/screens/authentication/signUpScreen.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:sizer/sizer.dart';

class EntryPointScreen extends StatefulWidget {
  const EntryPointScreen({Key? key}) : super(key: key);

  @override
  State<EntryPointScreen> createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
  }

  changeOpacity() {
    Future.delayed(const Duration(milliseconds: 1300), () {
      setState(() {
        opacity = 1.0;
        changeOpacity();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.centerLeft,
              height: 20.h,
              child: Image.asset(
                'assets/icons/Logo.png',
              ),
            ),
            SizedBox(
              // margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
              height: 40.h,
              child: Image.asset(
                'assets/icons/Frame.png',
                height: 7.h,
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 10.w, right: 20.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome to BookWorm.',
                  style: TextStyle(
                      color: black,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold),
                )),
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 1300),
              curve: Curves.decelerate,
              child: Container(
                  padding: EdgeInsets.only(top: 1.h, left: 10.w, right: 10.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'A platform that brings together book lovers to share their reviews and exchange books',
                    style: TextStyle(color: black, fontSize: 14.sp),
                  )),
            ),
            SizedBox(
              height: 7.h,
            ),
            Button(
              nextScreen: SignUpScreen(),
              text: 'Get Started',
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Already have an account?',
                    style: TextStyle(color: black, fontSize: 12.sp),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                  child: Container(
                    // padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      ' Log in.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: greenAccent,
                          fontSize: 12.sp),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }
}

class Button extends StatelessWidget {
  final Widget nextScreen;
  final String text;

  Button({
    Key? key,
    required this.nextScreen,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
      },
      child: Container(
          height: 6.h,
          width: 80.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: darkblue,
            gradient: gradient,
            // border: Border.all(color: black, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(text,
              style: TextStyle(
                  fontSize: 13.sp, color: black, fontWeight: FontWeight.bold))),
    ));
  }
}
