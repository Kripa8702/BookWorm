import 'package:flutter/material.dart';
import 'package:kimber/utils/colors.dart';
import 'package:sizer/sizer.dart';

class KimberLogo extends StatelessWidget {
  const KimberLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 1.h, left: 6.5.w),
        child: Text(
          'Kimber',
          style: TextStyle(color: white, fontSize: 28.sp),
        ));
  }
}
