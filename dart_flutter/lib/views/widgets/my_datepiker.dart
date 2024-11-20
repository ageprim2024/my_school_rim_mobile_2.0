
import 'package:flutter/material.dart';

import '../../tools/constants/colors.dart';
import '../../tools/constants/fonts.dart';
import '../../tools/constants/sizes.dart';
import 'my_icon.dart';
import 'my_textfield.dart';

class MyDatePiker extends StatelessWidget {
  final TextEditingController? controller;
  final bool readOnly;
  final String label;
  final double paddingH;
  final double paddingV;
  final void Function()? onPressed;
  final IconData? icon;
  final int coloricon;
  final double sizeIcon;
  const MyDatePiker({
    super.key,
    required this.label,
    this.controller,
    this.readOnly= true,
    this.paddingH = 0,
    this.paddingV =0,
    required this.onPressed,
    this.coloricon =bluelight,
    this.icon,
    this.sizeIcon = size10
  });

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      readOnly: readOnly,
      label:label,
      controller: controller,
      fontSize: font10,
      paddingH: paddingH,
      paddingV: paddingV,
      icon: IconButton(
        onPressed: onPressed,
        icon: MyIcon(
          color: coloricon,
          icon: icon,
          size: sizeIcon,
        ),
      ),
    );
  }
}
