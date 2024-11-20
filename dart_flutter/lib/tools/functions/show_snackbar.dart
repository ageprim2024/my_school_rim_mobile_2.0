import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/tools/constants/fonts.dart';
import 'package:my_school_rim/views/widgets/my_text.dart';

import '../../views/widgets/my_icon.dart';
import '../constants/colors.dart';

SnackbarController showSnackBar(String message,
    {int seconds = 3, int backgroundColor = gray, void Function()? onPressed}) {
  String title = "رسالة";
  IconData? icon;
  if (backgroundColor == green) {
    title = "تأكيد";
    icon = Icons.check_circle;
  } else if (backgroundColor == red) {
    title = "تنبيه";
    icon = Icons.error;
  } else if (backgroundColor == orang) {
    title = "انتباه";
    icon = Icons.warning;
  }
  return Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    duration: Duration(seconds: seconds),
    backgroundColor: Color(backgroundColor),
    colorText: const Color(white),
    icon: MyIcon(
      icon: icon,
      color: white,
    ),
    mainButton: onPressed != null
        ? TextButton(
            onPressed: onPressed,
            child: const Text(
              'تفاصيل',
              style:
                  TextStyle(color: Color(white), fontWeight: FontWeight.bold),
            ),
          )
        : null,
  );
}

SnackbarController showNotification({
  required String titleText,
  required String messageText,
}) {
  return Get.snackbar(
    '',
    '',
    titleText: MyText(
      data: titleText,
      fontSize: font18,
      color: black,
    ),
    messageText: MyText(
      data: messageText,
      fontSize: font16,
      color: black,
    ),
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 5),
    backgroundColor: const Color(white),
    icon: const MyIcon(
      icon: Icons.check_circle,
      color: blue,
    ),
  );
}
