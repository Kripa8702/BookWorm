import 'package:flutter/material.dart';
import 'package:kimber/functions/userApiCalls.dart';
import 'package:kimber/models/userModel.dart';
import 'package:kimber/screens/homeScreen.dart';
import 'package:kimber/utils/colors.dart';
import 'package:kimber/utils/utils.dart';
import 'package:kimber/widgets/inputField.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = "";
  String password = "";
  bool loading = false;

  UserApiCalls userApiCalls = UserApiCalls();

  login(String email, String password) async {
    setState(() {
      loading = true;
    });
    var newUser = await userApiCalls.loginUser(email, password);
    if (newUser != null) {
      setState(() {
        loading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      print("Success");
    } else {
      setState(() {
        loading = false;
      });
      showSnackBar("Something went wrong", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 3.h, left: 5.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: black,
                    ),
                  )),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 7.h, horizontal: 3.w),
                  // height: 80.h,
                  // width: 80.w,
                  decoration: BoxDecoration(
                      color: black, borderRadius: BorderRadius.circular(20)),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 6.h,
                        ),

                        //Email
                        InputField(
                          controller: emailController,
                          fieldType: 'Email ID',
                        ),

                        //Password
                        InputField(
                          controller: passwordController,
                          fieldType: 'Password',
                          isObscure: true,
                        ),
                        SizedBox(
                          height: 5.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }

                  print(emailController.text);
                  print(passwordController.text);
                  login(emailController.text, passwordController.text);
                },
                child: Container(
                  height: 6.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
                  decoration: BoxDecoration(
                      color: black, borderRadius: BorderRadius.circular(50)),
                  child: loading
                      ? Container(
                          height: 2.2.h,
                          width: 2.2.h,
                          child: const CircularProgressIndicator(
                            color: yellowAccent,
                            strokeWidth: 3.0,
                          ),
                        )
                      : Text(
                          'Login',
                          style:
                              TextStyle(color: yellowAccent, fontSize: 16.sp),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
