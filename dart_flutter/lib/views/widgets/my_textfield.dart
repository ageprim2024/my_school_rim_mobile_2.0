import 'package:flutter/material.dart';
import '../../tools/constants/fonts.dart';

class MyTextField extends StatelessWidget {
  final Function(String)? onChanged; 
  final TextEditingController? controller;
  final double paddingH;
  final double paddingV;
  final double fontSize;
  final TextAlign textAlign;
  final String label;
  final Widget? icon;
  final String? suffix;
  final TextInputType? keyboardType;
  final bool readOnly;
  final String? hintText;
  const MyTextField({
    super.key,
    this.onChanged,
    this.controller,
    this.paddingH = 12,
    this.paddingV =0,
    this.fontSize = font10,
    this.textAlign = TextAlign.start,
    required this.label,
    this.icon,
    this.suffix,
    this.keyboardType,
    this.readOnly = false,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingH,vertical:paddingV),
      child: TextField(

        onChanged: onChanged,
        readOnly: readOnly,
        controller: controller,
        textDirection: TextDirection.rtl,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold,),
        textAlign: textAlign,
        decoration: InputDecoration(
          hintText: hintText,
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              label,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
          ),
          prefixIcon:icon ,
          suffix: suffix != null
              ? Text(
                  "$suffix",
                  style: const TextStyle(
                      fontSize: font10, fontWeight: FontWeight.bold),
                )
              : null,
          
          contentPadding:
              const EdgeInsets.only(left: 6, right: 6, bottom: 0, top: 0),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
