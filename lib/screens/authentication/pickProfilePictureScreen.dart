// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:book_worm/firebaseResources/storageMethods.dart';
// import 'package:book_worm/functions/userApiCalls.dart';
// import 'package:book_worm/screens/navigation/homeScreen.dart';
// import 'package:book_worm/utils/colors.dart';
// import 'package:sizer/sizer.dart';
//
// class PickProfilePictureScreen extends StatefulWidget {
//   String userId;
//   PickProfilePictureScreen({Key? key, required this.userId}) : super(key: key);
//
//   @override
//   State<PickProfilePictureScreen> createState() => _PickProfilePictureScreenState();
// }
//
// class _PickProfilePictureScreenState extends State<PickProfilePictureScreen> {
//   Uint8List? image;
//   final ImagePicker _picker = ImagePicker();
//   bool loading = false;
//   TextEditingController aboutController = TextEditingController();
//
//   pickImage(ImageSource imageSource) async {
//     ImagePicker imagePicker = ImagePicker();
//
//     XFile? file = await imagePicker.pickImage(source: imageSource);
//     print(file?.path);
//     if (file != null) {
//       Uint8List img = await file.readAsBytes();
//       setState(() {
//         image = img;
//       });
//     }
//     else
//       print("No image selected");
//   }
//
//   uploadProfilePic(Uint8List image, String about) async{
//     setState(() {
//       loading = true;
//     });
//     String imageUrl = await StorageMethods().uploadImageToStorage(image, "user");
//     print(imageUrl);
//     var user = await UserApiCalls().updateProfilePic(imageUrl, about, widget.userId);
//     if (user != null) {
//       setState(() {
//         loading = false;
//       });
//       Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: black,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//                 margin: EdgeInsets.only(top: 3.h, left: 5.w),
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Personalize',
//                   style: TextStyle(
//                     fontSize: 32.sp,
//                     color: greyishWhite,
//                   ),
//                 )),
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
//                 child: SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   child: Column(
//                     children: [
//                       Container(
//                           margin: EdgeInsets.only(top: 3.5.h, left: 5.w),
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Add a profile picture',
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               color: greenAccent,
//                             ),
//                           )),
//                       SizedBox(
//                         height: 3.h,
//                       ),
//                       //ProfilePic
//                       Container(
//                         child: Stack(
//                           children: [
//                             image != null
//                                 ? CircleAvatar(
//                                 radius: 60,
//                                 backgroundImage: MemoryImage(image!)
//                             )
//                                 : CircleAvatar(
//                               radius: 60,
//                               child: Image.asset("assets/icons/user.png",
//                               height: 8.h,),
//                               backgroundColor: greyishWhite,
//                             ),
//                             Positioned(
//                               bottom: -10,
//                               left: 80,
//                               child: IconButton(
//                                 onPressed: () =>
//                                     pickImage(ImageSource.gallery),
//                                 icon: const Icon(Icons.add_a_photo,
//                                 color: greenAccent
//                                   ,),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//
//                       Container(
//                           margin: EdgeInsets.only(top: 10.h, left: 5.w),
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Help us get to know you better',
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               color: greenAccent,
//                             ),
//                           )),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 5.w),
//                         child: TextField(
//                           controller: aboutController,
//                           cursorColor: greenAccent,
//                           onChanged: (_) => setState(() {}),
//                           maxLines: 3,
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: greenAccent,
//                           ),
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: borderColor,
//                             isDense: true,
//                             hintText: 'I\'m kinda bipolar...',
//                             // hintStyle: TextStyle(
//                             //   fontSize: 14.sp,
//                             //   color: ,
//                             // ),
//                             contentPadding:
//                             EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
//                             border: InputBorder.none,
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 width: 2.0,
//                                 color: black,
//                               ), // BorderSide
//                             ),
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 width: 2.0,
//                                 color: black,
//                               ), // BorderSide
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 width: 2.0,
//                                 color: black,
//                               ), // BorderSide
//                             ),
//                             // OutlineInputBorder
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 width: 2.0,
//                                 color: greenAccent,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5.h,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 FocusScopeNode currentFocus = FocusScope.of(context);
//
//                 if (!currentFocus.hasPrimaryFocus) {
//                   currentFocus.unfocus();
//                 }
//                 if(image != null)
//                   uploadProfilePic(image!, aboutController.text);
//                 else
//                   Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
//
//               },
//               child: Container(
//                 height: 6.h,
//                 alignment: Alignment.center,
//                 margin: EdgeInsets.only(bottom: 3.h, left: 8.w, right: 8.w),
//                 decoration: BoxDecoration(
//                     color: greenAccent, borderRadius: BorderRadius.circular(50)),
//                 child: loading
//                     ? Container(
//                   height: 2.2.h,
//                   width: 2.2.h,
//                   child: const CircularProgressIndicator(
//                     color: darkblue,
//                     strokeWidth: 3.0,
//                   ),
//                 )
//                     : Text(
//                   'Lets Go!',
//                   style:
//                   TextStyle(color: darkblue, fontSize: 16.sp),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
