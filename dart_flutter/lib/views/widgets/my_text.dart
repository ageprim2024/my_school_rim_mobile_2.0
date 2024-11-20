import 'package:flutter/material.dart';

import '../../tools/constants/colors.dart';
import '../../tools/constants/fonts.dart';

class MyText extends StatelessWidget {
  final String data;
  final int color;
  final Color? backgroundColor;
  final double? fontSize;
  final TextDecoration? decoration;
  final double horizontal;
  final double vertical;
  final TextAlign? textAlign;
  const MyText({
    super.key,
    required this.data,
    this.color = black,
    this.backgroundColor,
    this.fontSize = font10,
    this.decoration,
    this.horizontal = 0.0,
    this.vertical = 0.0,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: Text(data,
          textAlign: textAlign,
          style: TextStyle(
              decoration: decoration,
              color: Color(color),
              fontSize: fontSize,
              fontWeight: FontWeight.bold)),
    );
  }
}
