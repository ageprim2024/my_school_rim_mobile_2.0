
import 'package:flutter/material.dart';

import '../../tools/constants/colors.dart';

class ContainerIndicator extends StatelessWidget {
  final double opacity;
  const ContainerIndicator({
    super.key,
    this.opacity =0.6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white.withOpacity(opacity),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Text('يرجى الانتظار قليلا'),
          CircularProgressIndicator(
            color: Color(orang),
            backgroundColor: Color(gray),
            strokeWidth: 5,
          ),
        ],
      ),
    );
  }
}

class ContainerNormal extends StatelessWidget {
  final AlignmentGeometry alignment;
  final Widget child;
  const ContainerNormal(
      {super.key, required this.child, this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: child,
      ),
    );
  }
}
