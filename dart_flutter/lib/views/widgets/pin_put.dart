import 'package:flutter/material.dart';
import 'package:my_school_rim/tools/constants/fonts.dart';
import 'package:my_school_rim/views/widgets/my_text.dart';
import 'package:pinput/pinput.dart';

class MyPinPut extends StatelessWidget {
  final String? label;
  final TextEditingController? pinController;
  final bool obscureText;
  final int length;
  const MyPinPut(
      {super.key,
      this.label,
      this.pinController,
      this.obscureText = true,
      this.length = 4});

  @override
  Widget build(BuildContext context) {
    const defaultPinTheme = PinTheme(
      width: 20,
      height: 35,
      textStyle: TextStyle(
        fontSize: font28,
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black))),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        MyText(data: label == null ? '' : '$label', fontSize: font10),
        Pinput(
          length: length,
          obscureText: obscureText,
          controller: pinController,
          defaultPinTheme: defaultPinTheme,
        ),
      ],
    );
  }
}
