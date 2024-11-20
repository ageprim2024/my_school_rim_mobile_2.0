import 'package:flutter/material.dart';

import '../../tools/constants/colors.dart';
import '../../tools/constants/fonts.dart';
import 'my_text.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double? fontSize;
  final String title;
  final List<Widget>? actions;
  const MyAppBar({
    super.key,
    required this.title,
    this.actions,
    this.fontSize =font12,
  });

  @override
  State<MyAppBar> createState() =>
      // ignore: no_logic_in_create_state
      _MyAppBarState(title: title, actions: actions,fontSize: fontSize);

  @override
  Size get preferredSize => const Size(0, 40);
}

class _MyAppBarState extends State<MyAppBar> {
  final double? fontSize;
  final String title;
  final List<Widget>? actions;

  _MyAppBarState({required this.title, this.actions,this.fontSize});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: MyText(data: title, color: white, fontSize: fontSize),
      backgroundColor: const Color(blue),
      foregroundColor: const Color(white),
      actions: actions,
    );
  }
}
