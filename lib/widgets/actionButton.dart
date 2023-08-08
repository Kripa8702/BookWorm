import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function onTap;
  final double height;
  final double width;
  final double radius;
  bool? isGlow = true;
  final Widget child;

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
          // decoration: BoxDecoration(
          //     // color: Color(0xFF00f7a7),
          //     gradient: gradient,
          //     borderRadius: BorderRadius.circular(widget.radius),
          //     boxShadow: [
          //       BoxShadow(
          //         color: (widget.isGlow ?? true)
          //             ? greenAccent.withAlpha(60)
          //             : Colors.transparent,
          //         blurRadius: 6.0,
          //         spreadRadius: 2.0,
          //       )
          //     ]),
          child: child),
    );
  }
}
