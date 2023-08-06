import 'dart:convert';

import 'package:book_worm/firebaseResources/authMethods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:book_worm/functions/userApiCalls.dart';
import 'package:book_worm/models/userModel.dart';
import 'package:book_worm/screens/authentication/pickProfilePictureScreen.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:book_worm/utils/utils.dart';
import 'package:book_worm/widgets/inputField.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  GlobalKey<FormState> _globalFormKey = GlobalKey();

  String username = "";
  String email = "";
  String password = "";
  bool loading = false;
  Uint8List? image;

  // selectImage() async {
  //   Uint8List img = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     image = img;
  //   });
  // }

  signUpUser() async {
    setState(() {
      loading = true;
    });
    String res = await AuthMethods().signUp(
        email: emailController.text,
        username: usernameController.text,
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
                  'Sign Up ',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: black,
                    fontWeight: FontWeight.bold
                  ),
                )),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [

                      SizedBox(
                        height: 3.5.h,
                      ),
                      Form(
                          key: _globalFormKey,
                          child: Column(
                            children: [
                              //Username
                              InputField(
                                controller: usernameController,
                                fieldType: 'Name',
                                hint: "Enter full name",
                                textCapitalization: TextCapitalization.sentences,
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
                              //Password
                              InputField(
                                controller: confirmpasswordController,
                                fieldType: 'Confirm Password',
                                isObscure: true,
                                hint: "Re-enter password",

                              ),
                            ],
                          )),
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
                if (_globalFormKey.currentState!.validate()) {
                  print(usernameController.text);
                  print(emailController.text);
                  signUpUser();
                }
              },
              child: Container(
                height: 6.h,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 3.h, left: 8.w, right: 8.w),
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
                        'Sign Up',
                        style:
                            TextStyle(color: white, fontSize: 13.sp,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
