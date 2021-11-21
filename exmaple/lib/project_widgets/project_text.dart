import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight; 

  const ProjectText(
      {Key? key, required this.text, this.color, this.fontSize = 14, this.fontWeight}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: color,
        fontSize: fontSize!.w,
      ),
    );
  }
}
  