import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kimber/functions/userApiCalls.dart';
import 'package:kimber/models/userModel.dart';
import 'package:kimber/utils/colors.dart';
import 'package:kimber/utils/utils.dart';
import 'package:kimber/widgets/inputField.dart';
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

  String username = "";
  String email = "";
  String password = "";
  bool loading = false;

  // Uint8List? image;
  // final ImagePicker _picker = ImagePicker();

  UserApiCalls userApiCalls = UserApiCalls();

  // pickImage(ImageSource imageSource) async {
  //   ImagePicker imagePicker = ImagePicker();
  //
  //   XFile? file = await imagePicker.pickImage(source: imageSource);
  //   print(file?.path);
  //   if (file != null) {
  //     Uint8List img = await file.readAsBytes();
  //     setState(() {
  //       image = img;
  //     });
  //   }
  //   else
  //     print("No image selected");
  // }

  signUpUser(String username, String email, String password) async {
    setState(() {
      loading = true;
    });
    var newUser = await userApiCalls.registerUser(username, email, password);
    if (newUser != null) {
      setState(() {
        loading = false;
      });
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
                    'SignUp',
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: black,
                    ),
                  )),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
                  // height: 80.h,
                  // width: 80.w,
                  decoration: BoxDecoration(
                      color: black, borderRadius: BorderRadius.circular(20)),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 3.5.h,
                        ),
                        //ProfilePic
                        // Stack(
                        //   children: [
                        //     image != null
                        //         ? CircleAvatar(
                        //         radius: 50,
                        //         backgroundImage: MemoryImage(image!)
                        //     )
                        //         : const CircleAvatar(
                        //       radius: 50,
                        //       child: Icon(
                        //           Icons.person_outline,
                        //         size: 50,
                        //         color: black,
                        //       ),
                        //       backgroundColor: borderColor,
                        //     ),
                        //     Positioned(
                        //       bottom: -14,
                        //       left: 55,
                        //       child: IconButton(
                        //         onPressed: () =>
                        //             pickImage(ImageSource.gallery),
                        //         icon: const Icon(Icons.add_a_photo,
                        //         color: darkBlueAccent
                        //           ,),
                        //       ),
                        //     )
                        //   ],
                        // ),

                        //Username
                        InputField(
                          controller: usernameController,
                          fieldType: 'Usename',
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

                  print(usernameController.text);
                  print(emailController.text);
                  print(passwordController.text);
                  signUpUser(usernameController.text, emailController.text,
                      passwordController.text);
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
                          'SignUp',
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
