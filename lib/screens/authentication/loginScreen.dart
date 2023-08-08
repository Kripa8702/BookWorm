import 'package:book_worm/firebaseResources/authMethods.dart';
import 'package:flutter/material.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:book_worm/utils/utils.dart';
import 'package:book_worm/widgets/inputField.dart';
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

  loginUser() async {
    setState(() {
      loading = true;
    });
    String res = await AuthMethods().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    print(res);

    setState(() {
      loading = false;
    });

    if (res != "success") {
      showSnackBar(res, context);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 10.h, left: 6.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Log In ',
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: black,
                      fontWeight: FontWeight.bold),
                )),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                // height: 80.h,
                // width: 80.w,
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
                        hint: "Enter email address",
                      ),

                      //Password
                      InputField(
                        controller: passwordController,
                        fieldType: 'Password',
                        isObscure: true,
                        hint: "Enter password",
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
                loginUser();
              },
              child: Container(
                height: 6.h,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 8.h, left: 8.w, right: 8.w),
                decoration: BoxDecoration(
                    color: blueAccent, borderRadius: BorderRadius.circular(10)),
                child: loading
                    ? Container(
                        height: 2.2.h,
                        width: 2.2.h,
                        child: const CircularProgressIndicator(
                          color: white,
                          strokeWidth: 3.0,
                        ),
                      )
                    : Text(
                        'Log In',
                        style: TextStyle(
                            color: white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
