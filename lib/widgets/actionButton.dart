import 'package:flutter/material.dart';
import 'package:kimber/utils/colors.dart';
import 'package:sizer/sizer.dart';

class ActionButton extends StatelessWidget {
  Function onTap;
  double height;
  double width;
  double radius;
  bool? isGlow = true;
  Widget child;

  ActionButton({
    Key? key,
    required this.onTap,
    required this.height,
    required this.width,
    required this.radius,
    required this.child,
    this.isGlow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
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
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  color: (isGlow ?? true)
                      ? yellowAccent2.withAlpha(60)
                      : Colors.transparent,
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                )
              ]),
          child: child),
    );
  }
}
