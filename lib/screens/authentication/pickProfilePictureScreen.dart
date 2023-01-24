import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kimber/functions/storageMethods.dart';
import 'package:kimber/functions/userApiCalls.dart';
import 'package:kimber/screens/homeScreen.dart';
import 'package:kimber/utils/colors.dart';
import 'package:sizer/sizer.dart';

class PickProfilePictureScreen extends StatefulWidget {
  String userId;
  PickProfilePictureScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<PickProfilePictureScreen> createState() => _PickProfilePictureScreenState();
}

class _PickProfilePictureScreenState extends State<PickProfilePictureScreen> {
  Uint8List? image;
  final ImagePicker _picker = ImagePicker();
  bool loading = false;
  TextEditingController aboutController = TextEditingController();

  pickImage(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: imageSource);
    print(file?.path);
    if (file != null) {
      Uint8List img = await file.readAsBytes();
      setState(() {
        image = img;
      });
    }
    else
      print("No image selected");
  }

  uploadProfilePic(Uint8List image, String about) async{
    setState(() {
      loading = true;
    });
    String imageUrl = await StorageMethods().uploadImageToStorage(image, "user", false, widget.userId);
    print(imageUrl);
    var user = await UserApiCalls().updateProfilePic(imageUrl, about, widget.userId);
    if (user != null) {
      setState(() {
        loading = false;
      });
      Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
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
                    'Personalize',
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: black,
                    ),
                  )),
              Expanded(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
                    // height: 80.h,
                    width: 95.w,
                    decoration: BoxDecoration(
                        color: black, borderRadius: BorderRadius.circular(20)),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 3.5.h, left: 5.w),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Profile Picture',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: white,
                                ),
                              )),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          //ProfilePic
                          Container(
                            child: Stack(
                              children: [
                                image != null
                                    ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: MemoryImage(image!)
                                )
                                    : const CircleAvatar(
                                  radius: 64,
                                  child: Icon(
                                      Icons.person_outline,
                                    size: 70,
                                    color: black,
                                  ),
                                  backgroundColor: borderColor,
                                ),
                                Positioned(
                                  bottom: -10,
                                  left: 80,
                                  child: IconButton(
                                    onPressed: () =>
                                        pickImage(ImageSource.gallery),
                                    icon: const Icon(Icons.add_a_photo,
                                    color: darkBlueAccent
                                      ,),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Container(
                              margin: EdgeInsets.only(top: 4.h, bottom: 2.h, left: 5.w),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Help us get to know you better',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: white,
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: TextField(
                              controller: aboutController,
                              cursorColor: yellowAccent,
                              onChanged: (_) => setState(() {}),
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: yellowAccent,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: borderColor,
                                isDense: true,
                                hintText: 'I\'m kinda bipolar...',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: black,
                                ),
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: black,
                                  ), // BorderSide
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: black,
                                  ), // BorderSide
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: black,
                                  ), // BorderSide
                                ),
                                // OutlineInputBorder
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: yellowAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          )
                        ],
                      ),
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
                  if(image != null)
                    uploadProfilePic(image!, aboutController.text);
                  else
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);

                },
                child: Container(
                  height: 6.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 3.h, left: 3.w, right: 3.w),
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
                    'Lets Go!',
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
