import 'package:book_worm/models/selectionModel.dart';
import 'package:book_worm/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SelectionItemWidget extends StatelessWidget {
  final Selection name;
  final Color textColor;
  final Color backgroundColor;

  SelectionItemWidget({required this.name, required this.textColor, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: greenAccent.withOpacity(0.5), shape: BoxShape.rectangle),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      child: Row(
        children: [
          SizedBox(width: 6),
          Container(
              width: 26,
              height: 26,
              child: const Icon(Icons.done, size: 23, color: Colors.black),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: backgroundColor),
          ),
          SizedBox(width: 12),
          Align(
            alignment: Alignment.center,
            child: Text(
              name.name,
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}