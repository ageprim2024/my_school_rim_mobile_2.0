
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final String name;
  final String folder;
  final double? height;
  final double? width;
  const MyImage({super.key, required this.name,this.folder="images",this.height,this.width});

  @override
  Widget build(BuildContext context) {
    return Image(
      height: height,
      width: width,
      image: AssetImage("assets/$folder/$name.png"),
    );
  }
}