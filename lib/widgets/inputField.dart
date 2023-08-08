import 'package:flutter/material.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:sizer/sizer.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String fieldType;
  final String hint;
  bool? isObscure = false;
  bool? isChat = false;
  TextCapitalization? textCapitalization = TextCapitalization.none;

  InputField({
    Key? key,
    required this.controller,
    required this.fieldType,
    required this.hint,
    this.isObscure,
    this.isChat,
    this.textCapitalization,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!(widget.isChat ?? false))
          Container(
              margin: EdgeInsets.only(top: 3.h, left: 5.w),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.fieldType,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: black,
                ),
              )),
        Container(
          margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
          child: TextFormField(
            controller: widget.controller,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            cursorColor: blueAccent,
            obscureText: widget.isObscure ?? false,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This is a required field';
              } else if ((widget.isObscure ?? false) && value.length < 6) {
                return 'Password is too short';
              }
              return null;
            },
            style: TextStyle(
              fontSize: 14.sp,
              color: blueAccent,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: 13.sp,
                // color: blueAccent,
              ),
              filled: true,
              fillColor: borderColor,
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 10),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                ), // BorderSide
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 2.0,
                  color: black,
                ), // BorderSide
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 2.0,
                  color: black,
                ), // BorderSide
              ),
              // OutlineInputBorder
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 2.0,
                  color: blueAccent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
