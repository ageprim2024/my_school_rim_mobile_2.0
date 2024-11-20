import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/creer_compte_controller.dart';
import '../../tools/constants/colors.dart';
import '../../tools/constants/fonts.dart';
import '../../tools/constants/sizes.dart';
import '../widgets/container_indicator.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_button.dart';
import '../widgets/my_icon.dart';
import '../widgets/my_image.dart';
import '../widgets/my_text.dart';
import '../widgets/my_textfield.dart';
import '../widgets/pin_put.dart';

class CreerComptePage extends StatelessWidget {
  final CreerCompteController createController = Get.find();
  CreerComptePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'صفحة انشاء حساب'),
      body: Stack(children: [
        ContainerNormal(
          child: Column(children: [
            const MyImage(
              name: 'logo',
              height: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const MyText(
              data: 'البيانات المطلوبة لإنشاء حساب',
              fontSize: font14,
            ),
            MyTextField(
              controller: createController.nomController,
              label: 'الاسم الشخصي',
              icon: const MyIcon(icon: Icons.person),
              keyboardType: TextInputType.name,
            ),
            GetBuilder<CreerCompteController>(
              builder: (controller) => MyTextField(
                onChanged: (value) {
                  controller.setCompagneTel();
                },
                label: 'رقم الهاتف',
                controller: createController.phoneController,
                icon: const MyIcon(icon: Icons.phone),
                paddingH: 80,
                suffix: controller.compagnePhone,
                keyboardType: TextInputType.phone,
              ),
            ),
            MyPinPut(
              pinController: createController.passwordController,
              label: 'الرمز السري',
            ),
            const SizedBox(
              height: size12,
            ),
            const Divider(),
            const MyText(
                data:
                    'قم بصياغة سؤال الأمان كيف تشاء، وضع إجابة له من اختيارك انت ثم احفظ الإجابة جيدا',
                color: blue),
            MyTextField(
              controller: createController.askCodeController,
              label: 'سؤال الأمان',
              hintText: 'ضع سؤالا من اختيارك',
            ),
            MyTextField(
              controller: createController.answerController,
              label: 'الإجابة',
              hintText: 'ضع إجابة تختارها',
            ),
            const MyText(
                data:
                    'هذه الخطوة ضرورية جدا في حال نسيان الرمز السري أو في حال غلق الحساب أو فتح آخر',
                color: red),
            const SizedBox(
              height: size28,
            ),
            MyButton(
              onPressed: () {
                createController.creerCompte();
              },
              data: 'إنشاء حساب',
              fontSize: font12,
            ),
          ]),
        ),
        GetBuilder<CreerCompteController>(
          builder: (controller) => Container(
            child:
                controller.loading == true ? const ContainerIndicator() : null,
          ),
        )
      ]),
    );
  }
}
