import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/tools/constants/colors.dart';
import 'package:my_school_rim/tools/constants/fonts.dart';
import 'package:my_school_rim/tools/constants/sizes.dart';
import 'package:my_school_rim/views/widgets/my_button.dart';
import 'package:my_school_rim/views/widgets/my_icon.dart';
import 'package:my_school_rim/views/widgets/my_text.dart';
import 'package:my_school_rim/views/widgets/my_textfield.dart';
import 'package:my_school_rim/views/widgets/pin_put.dart';

import '../../controllers/login_controller.dart';
import '../../main.dart';
import '../../tools/constants/expression.dart';
import '../widgets/container_indicator.dart';
import '../widgets/my_image.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.find();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        builder: (controller) => Scaffold(
              body: Stack(children: [
                ContainerNormal(
                  child: Column(
                    children: [
                      mySharedPreferences!.getString(sharedPreferencesID) == '1'
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MyIcon(
                                  icon: Icons.refresh,
                                  size: size30,
                                  color: blue,
                                  onTap: () {
                                    loginController.refleshirCompte();
                                  },
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const MyImage(
                        name: 'logo',
                        height: 200,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyTextField(
                        onChanged: (value) {
                          controller.setCompagneTel();
                        },
                        readOnly: true,
                        controller: controller.phoneController,
                        label: 'رقم الهاتف',
                        icon: const MyIcon(icon: Icons.phone),
                        keyboardType: TextInputType.phone,
                        paddingH: 80,
                        suffix: controller.compagnePhone,
                      ),
                      MyPinPut(
                        pinController: loginController.passwordController,
                        label: 'الرمز السري',
                      ),
                      const SizedBox(height: size10),
                      MyButton(
                        onPressed: () {
                          loginController.login();
                        },
                        data: 'تسجيل الدخول',
                        fontSize: font14,
                        color: green,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const MyText(
                                    data: 'نسيت الرمز السري؟', color: blue),
                                const SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  onTap: () {
                                    loginController.getPassword();
                                  },
                                  child: const MyText(
                                    data: 'اضغط هنا',
                                    color: red,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const MyText(
                                  data: 'ليس لديك حساب؟',
                                  color: blue,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                    onTap: () {
                                      loginController.pasDeCompte();
                                    },
                                    child: const MyText(
                                      data: 'اضغط هنا',
                                      color: red,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: size12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const MyText(
                            data: 'لديك حساب، تريد فتحه على هذا الهاتف',
                            color: blue,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: () {
                              controller.ouvrirCompte();
                            },
                            child: const MyText(
                              data: 'اضغط هنا',
                              color: red,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      mySharedPreferences!.getString(sharedPreferencesID) == '1'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const MyText(
                                  data: 'لديك حساب على هذا الهاتف، تريد إغلاقه',
                                  color: blue,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.fermerCompte();
                                  },
                                  child: const MyText(
                                    data: 'اضغط هنا',
                                    color: red,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: size22,
                      ),
                      const MyText(data: 'للاتصال'),
                      const SizedBox(
                        height: size14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyIcon(
                            icon: Icons.phone,
                            onTap: () {
                              //loginController.callLunchContact('22660920');
                            },
                          ),
                          const SizedBox(
                            width: size14,
                          ),
                          const MyIcon(
                            icon: Icons.email,
                          ),
                          const SizedBox(
                            width: size14,
                          ),
                          const MyIcon(
                            icon: Icons.facebook,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  child: controller.loading == true
                      ? const ContainerIndicator()
                      : null,
                ),
              ]),
            ));
  }
}
