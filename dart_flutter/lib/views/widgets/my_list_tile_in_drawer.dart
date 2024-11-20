import 'package:flutter/material.dart';

import '../../tools/constants/colors.dart';
import '../../tools/constants/fonts.dart';
import 'my_icon.dart';
import 'my_text.dart';

class MyListTileInDrawer extends StatelessWidget {
  final String data;
  final double? fontSize;
  final double horizontal;
  final double vertical;
  final IconData? icon;
  final IconData? icondetail;
  final int iconcolor;
  final void Function()? onTap;
  const MyListTileInDrawer({
    super.key,
    required this.data,
    this.fontSize = font10,
    this.horizontal = 12,
    this.vertical = 4,
    this.icon,
    this.icondetail,
    this.iconcolor = orang,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: MyText(
        data: data,
        fontSize: fontSize,
        horizontal: 12,
        vertical: 4,
      ),
      leading: MyIcon(icon: icon, color: iconcolor),
      trailing:
          MyIcon(icon: icondetail, color: black, textDirection: TextDirection.ltr),
      onTap: onTap,
    );
  }
}
