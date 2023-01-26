import 'package:flutter/material.dart';
import 'package:kimber/screens/authentication/loginScreen.dart';
import 'package:kimber/screens/authentication/signUpScreen.dart';
import 'package:kimber/utils/colors.dart';
import 'package:kimber/widgets/actionButton.dart';
import 'package:kimber/widgets/kimberLogo.dart';
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
    Future.delayed(Duration(milliseconds: 1300), () {
      setState(() {
        opacity = 1.0;
        changeOpacity();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                padding: EdgeInsets.only(top: 45.h, left: 10.w, right: 20.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome to Kimber.',
                  style: TextStyle(color: greyishWhite, fontSize: 28.sp),
                )),
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 1300),
              curve: Curves.decelerate,
              child: Container(
                  padding: EdgeInsets.only(top: 1.h, left: 10.w, right: 10.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'We appreciate offensive content from highly depressive individuals.',
                    style: TextStyle(color: greyishWhite, fontSize: 14.sp),
                  )),
            ),
            SizedBox(
              height: 10.h,
            ),
            Button(
              nextScreen: SignUpScreen(),
              text: 'Create new account',
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Already have an account?',
                    style: TextStyle(color: greyishWhite, fontSize: 12.sp),
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
                          fontWeight: FontWeight.bold, color: greenAccent, fontSize: 12.sp),
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
  Widget nextScreen;
  String text;

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
            // border: Border.all(color: greyishWhite, width: 2.0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(text, style: TextStyle(fontSize: 16.sp, color: black))),
    ));
  }
}
