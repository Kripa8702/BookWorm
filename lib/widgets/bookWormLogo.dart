import 'package:flutter/material.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:book_worm/widgets/gradientText.dart';
import 'package:sizer/sizer.dart';

class BookWormLogo extends StatelessWidget {
  final double fontSize;
  BookWormLogo({Key? key, required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 1.h, left: 5.w),
        child: GradientText('BookWorm',
            gradient: gradient,
            style: TextStyle(
                color: white, fontSize: fontSize, fontWeight: FontWeight.bold))
        // Text(
        //   'BookWorm',
        //   style: TextStyle(color: white, fontSize: 28.sp),
        // )
        );
  }
}
