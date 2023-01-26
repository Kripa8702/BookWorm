import 'package:flutter/material.dart';
import 'package:kimber/utils/colors.dart';
import 'package:kimber/widgets/gradientText.dart';
import 'package:sizer/sizer.dart';

class KimberLogo extends StatelessWidget {
  double fontSize;
  KimberLogo({Key? key, required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 1.h, left: 3.w),
        child: GradientText('Kimber',
            gradient: gradient,
            style: TextStyle(color: white, fontSize: fontSize)
        )
        // Text(
        //   'Kimber',
        //   style: TextStyle(color: white, fontSize: 28.sp),
        // )
    );
  }
}
