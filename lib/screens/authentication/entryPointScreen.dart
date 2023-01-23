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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: 60.h,
                width: 100.w,
                padding: EdgeInsets.only(top: 45.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Color(0xFF00f7a7),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.1, 0.9],
                    colors: [
                      blue,
                      yellowAccent2,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                ),
                child: Text(
                  'Kimber',
                  style: TextStyle(color: black, fontSize: 28.sp),
                )),
            SizedBox(
              height: 10.h,
            ),
            Button(
              nextScreen: SignUpScreen(),
              text: 'SignUp',
            ),
            SizedBox(
              height: 5.h,
            ),
            Button(
              nextScreen: LoginScreen(),
              text: 'Login',
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
          height: 5.h,
          width: 70.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: Color(0xFF00f7a7),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.9],
              colors: [
                blue,
                yellowAccent2,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(text, style: TextStyle(fontSize: 16.sp))),
    ));
  }
}
