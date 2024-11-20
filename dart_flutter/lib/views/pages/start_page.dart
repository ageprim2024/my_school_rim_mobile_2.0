import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:my_school_rim/main.dart';
import 'package:my_school_rim/tools/constants/colors.dart';

import '../../tools/constants/expression.dart';
import '../widgets/my_image.dart';
import 'home_page.dart';
import 'login_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: const Color(white),
      duration: 3000,
      animationDuration: const Duration(seconds: 1, milliseconds: 500),
      splashIconSize: double.infinity,
      splashTransition: SplashTransition.fadeTransition,
      splash: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyImage(name: "logo"),
          Text(
            'El Ghazali © 2024',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          )
        ],
      ),
      nextScreen: mySharedPreferences!.getBool(sharedPreferencesLogined) == true
          ? HomePage()
          : LoginPage(),
    );
  }
}
