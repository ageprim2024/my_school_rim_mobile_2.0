import 'package:flutter/material.dart';

import '../../tools/constants/colors.dart';

class MyFloatingActionButton extends StatelessWidget {
  final int color;
  final void Function()? onPressed;
  final IconData? icon;
  const MyFloatingActionButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.color = blue,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Color(color),
      child: Icon(icon, color: const Color(white)),
    );
  }
}
