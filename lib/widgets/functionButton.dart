import 'package:book_worm/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FunctionButton extends StatelessWidget {
  final BuildContext context;
  final void Function()? onTap;
  final String text;
  final Color bgColor;

  FunctionButton({
    super.key,
    required this.context,
    required this.onTap,
    required this.text,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 6.h,
        width: 60.w,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 3.h),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: TextStyle(color: darkblue, fontSize: 13.sp),
        ),
      ),
    );
  }
}
