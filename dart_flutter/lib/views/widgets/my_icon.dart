
import 'package:flutter/material.dart';

import '../../tools/constants/colors.dart';
import '../../tools/constants/sizes.dart';

class MyIcon extends StatelessWidget {
  final void Function()? onTap;
  final IconData?  icon;
  final int color;
  final double size;
  final TextDirection? textDirection;
  const MyIcon({
    super.key,
    this.icon,
    this.color = bluelight,
    this.size = size20,
    this.textDirection,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: Color(color),
        size: size,
        textDirection: textDirection,
      ),
    );
  }
}