import 'package:flutter/material.dart';
import 'package:kimber/utils/colors.dart';
import 'package:sizer/sizer.dart';

class InputField extends StatefulWidget {
  TextEditingController controller;
  String fieldType;
  bool? isObscure = false;

  InputField(
      {Key? key,
      required this.controller,
      required this.fieldType,
      this.isObscure})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 3.5.h, left: 5.w),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.fieldType,
              style: TextStyle(
                fontSize: 16.sp,
                color: white,
              ),
            )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          child: TextFormField(
            controller: widget.controller,
            cursorColor: yellowAccent,
            obscureText: widget.isObscure ?? false,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This is a required field';
              } else if (widget.isObscure ?? false) if (value.length < 10) {
                return 'Password is too short';
              }
              return null;
            },
            style: TextStyle(
              fontSize: 14.sp,
              color: yellowAccent,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: borderColor,
              isDense: true,
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
      ],
    );
  }
}
