import 'package:flutter/material.dart';
import 'package:kimber/utils/colors.dart';
import 'package:sizer/sizer.dart';

class ActionButton extends StatefulWidget {
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
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap(),
      child: Container(
          height: widget.height,
          width: widget.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              // color: Color(0xFF00f7a7),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.9],
                colors: [
                  blue,
                  yellowAccent2,
                ],
              ),
              borderRadius: BorderRadius.circular(widget.radius),
              boxShadow: [
                BoxShadow(
                  color: (widget.isGlow ?? true)
                      ? yellowAccent2.withAlpha(60)
                      : Colors.transparent,
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                )
              ]),
          child: widget.child),
    );
  }
}
