
import 'package:flutter/material.dart';

import 'my_icon.dart';
import 'my_textfield.dart';

class MyDropDown extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final void Function()? onPressed;
  final IconData? icon;
  const MyDropDown({
    super.key,
    this.controller,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      readOnly: true,
      label:label,
      controller: controller,
      icon: IconButton(
          onPressed: onPressed,
          icon: MyIcon(
            icon: icon,
          )),
    );
  }
}