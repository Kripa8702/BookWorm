import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:kimber/models/userModel.dart';
import 'package:kimber/utils/colors.dart';
import 'package:kimber/utils/utils.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var user;
  final FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  Color textColor = white;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    String? currentUser = await storage.read(key: 'currentUser');
    var user = UserModel.decode(currentUser ?? "");
    print(user);
    setState(() {
      this.user = user[0];
    });
    Color color = await useWhiteTextColor(this.user.profilePic);
    setState(() {
      textColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      bottom: false,
      top: false,
      child: Container(
        height: 100.h,
        width: 100.w,
        child: Stack(
          alignment: Alignment.center,
          // fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: 60.h,
                width: 100.w,
                child: Image.network(
                  user.profilePic,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        color: greenAccent,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              // bottom: 1.h,
              left: 30.w,
              child: GlassContainer(
                blur: 4,
                // color: textColor.withOpacity(1),
                // gradient: RadialGradient(
                //   // begin: Alignment.topLeft,
                //   // end: Alignment.bottomRight,
                //   colors: [
                //     (textColor.computeLuminance() > 0.5 ? Colors.black : Colors.white).withOpacity(1),
                //     Colors.blue.withOpacity(1),
                //   ],
                // ),
                border: Border.all(color: textColor.withOpacity(0.2), width: 1.5),
                shadowStrength: 5,
                shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(50),
                shadowColor: textColor.withOpacity(0.24),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.8.h),
                  alignment: Alignment.center,
                  color:(textColor.computeLuminance() > 0.5 ? Colors.black : Colors.white).withOpacity(0.2),
                  child: Text(
                    '@${user.username}',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16.sp,
                      // fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                // top: 50.h,
                bottom: 0,
                child: Container(
                  height: 45.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: greyishWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 3.w),
                        child: Row(
                          children: [],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
