import 'package:flutter/material.dart';

import '../../tools/constants/colors.dart';
import '../../tools/constants/fonts.dart';

class MyButton extends StatelessWidget {
  final double vertical;
  final double paddingH;
  final double? minWidth;
  final String data;
  final double? fontSize;
  final int color;
  final int colortext;
  final void Function()? onPressed;
  const MyButton({
    super.key,
    this.vertical = 8,
    this.paddingH = 0,
    this.color = blue,
    this.colortext = white,
    this.minWidth =120,
    this.fontSize =font10,
    required this.onPressed,
    required this.data,
    
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical,horizontal: paddingH),
      child: Material(
        color: Color(color),
        borderRadius: BorderRadius.circular(12),
        child: MaterialButton(
            minWidth: minWidth,
            onPressed: onPressed,
            child: Text(
             data,
              style: TextStyle(
                  fontSize: fontSize,
                  color: Color(colortext),
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
